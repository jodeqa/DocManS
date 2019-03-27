unit unDMSScanADF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, FileCtrl, FolderMon, Buttons, ComCtrls,
  ShellAPI, CheckLst;

type
  TfrmDMSScanADF = class(TForm)
    mmLogs: TMemo;
    Panel1: TPanel;
    pgc: TPageControl;
    tbsCOP: TTabSheet;
    tbsBPK: TTabSheet;
    Panel2: TPanel;
    btImport: TSpeedButton;
    btScan: TSpeedButton;
    clbxCOP: TCheckListBox;
    clbxBPK: TCheckListBox;
    btExit: TSpeedButton;
    tbsOther: TTabSheet;
    btAll: TSpeedButton;
    Label1: TLabel;
    cbxScanGrp: TComboBox;
    Label2: TLabel;
    edScanName: TEdit;
    chbxIsRreminder: TCheckBox;
    grbxReminder: TGroupBox;
    Label3: TLabel;
    edBulan: TEdit;
    udBulan: TUpDown;
    Label4: TLabel;
    Label5: TLabel;
    dtpRemindWhen: TDateTimePicker;
    chbxRemindOnce: TCheckBox;
    pnSCOP: TPanel;
    edSCOP: TEdit;
    pnSBPK: TPanel;
    edSBPK: TEdit;
    tbsOLease: TTabSheet;
    pnSOLE: TPanel;
    edSOLE: TEdit;
    clbxOLE: TCheckListBox;
    procedure ReCenter;
    procedure OtherScanSetting;
    procedure checkFile(inComingFile : TFileName);
    procedure switchAble;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure btImportClick(Sender: TObject);
    procedure btScanClick(Sender: TObject);
    procedure btExitClick(Sender: TObject);
    procedure pgcChange(Sender: TObject);
    procedure btAllClick(Sender: TObject);
    procedure chbxIsRreminderClick(Sender: TObject);
    procedure cbxScanGrpKeyPress(Sender: TObject; var Key: Char);
    procedure edScanNameExit(Sender: TObject);
    procedure chbxRemindOnceKeyPress(Sender: TObject; var Key: Char);
    procedure edBulanExit(Sender: TObject);
    procedure chbxIsRreminderExit(Sender: TObject);
    procedure chbxRemindOnceExit(Sender: TObject);
    procedure edSCOPKeyPress(Sender: TObject; var Key: Char);
  private
    FFolderMon: TFolderMon;
    procedure HandleFolderChange(ASender: TFolderMon; AFolderItem: TFolderItemInfo);
    { Private declarations }
  public
    { Public declarations }
  end;


var
  frmDMSScanADF: TfrmDMSScanADF;
  dmsFolder : String;
  cCount : Integer;
  fileDat: TFileName;
  docCount : Integer;
  svrLayOut, crowList : TStringList;

implementation

uses GenericFP, unDocManSData, unDMSScanSelect;
{$R *.dfm}


procedure FileSystemAction(action:longint;fromDir,toDir:string);
var SHFileOp:TSHFileOpStruct;
begin
  SHFileOp.wnd    := frmDMSScanADF.handle;
  SHFileOp.wFunc  := action;
  SHFileOp.pFrom  := Pchar(fromDir +#0+#0);
  SHFileOp.pTo    := Pchar(toDir +#0+#0);
  SHFileOp.fFlags := FOF_SILENT or FOF_NOCONFIRMATION;
  SHFileOp.fAnyOperationsAborted := false;
  SHFileOp.hNameMappings := NIL;
  SHFileOp.lpszProgressTitle := NIL;
  SHFileOperation(SHFileOp);
end;

procedure TfrmDMSScanADF.ReCenter;
var
  LRect: TRect;
  X, Y: Integer;
begin
  LRect := Screen.WorkAreaRect;
  X := LRect.Left + (LRect.Right - LRect.Left - Width) div 2;
  Y := LRect.Top + (LRect.Bottom - LRect.Top - Height) div 2;
  SetBounds(X, Y, Width, Height);
end;

procedure TfrmDMSScanADF.OtherScanSetting;
begin
  cbxScanGrp.Items.Clear;
  cbxScanGrp.Items := getScanGroup(3);
  cbxScanGrp.ItemIndex := 0;
  chbxIsRreminder.Checked := False;
  edScanName.Text := '';
  udBulan.Position := 0;
  dtpRemindWhen.Date := Date;
  chbxRemindOnce.Checked := true;

  cCount := 1;
  cbxScanGrp.SetFocus;
end;

procedure TfrmDMSScanADF.switchAble;
begin
  Width := 490;
  //btImport.Enabled := not btImport.Enabled;
  //btExit.Enabled := not btExit.Enabled;
end;

procedure TfrmDMSScanADF.FormShow(Sender: TObject);
var svrData,svrFolder,svrBranch, usrName, usrSalt : String;
    isOK : Boolean;
    vMonitoredChanges: TChangeTypes;
    iTry, eco, fileNotFound, i : integer;
    tmpClbx : TCheckListBox;
begin
  Width := 490;

  svrBranch := getDBConfig(3);
  svrData := getDBConfig(5);
  svrFolder := getDBConfig(6);
  usrName := getDBConfig(8);
  usrSalt := getDBConfig(9);

  dmsFolder := '\\' + svrData + '\' + svrFolder;
  isOK := false;
  mmLogs.Clear;

  if pgc.ActivePageIndex = pgc.PageCount - 1 then OtherScanSetting;

  svrLayOut := TStringList.Create;
  svrLayOut := getLayOut(StrToInt(getDBConfig(1)));
  docCount := StrToInt(svrLayOut.Strings[8]);

  crowList := TStringList.Create;
  crowList := docLayOut(svrLayOut);

  //if ConnectDrive('soffatfs01\orca','050508r4d4r',dms,'',eco)
  for iTry := 1 to 3 do
    begin
      if ConnectDrive(usrName,usrSalt,dmsFolder,'',eco) then
        begin
          isOK := true;
          break;
        end;
    end;

  if isOK then
    begin
      fileNotFound := 0;
      for i := 0 to crowList.Count-1 do
        begin
          pgc.Pages[i].TabVisible := true;
          if crowList.Strings[i] <> '-' then
            begin
              fileDat := ExtractFilePath(Application.ExeName) + SelectSplitString(crowList.Strings[i],1) + '.dat';
              if FileExists(fileDat) then
                begin
                  tmpClbx := FindComponent('clbx'+SelectSplitString(crowList.Strings[i],1)) as TCheckListBox;
                  if tmpClbx <> nil then
                    begin
                      tmpClbx.Clear;
                      tmpClbx.Items.LoadFromFile(fileDat);
                    end;
                end
              else inc(fileNotFound,1);
            end
          else pgc.Pages[i].TabVisible := false;
        end;

      if fileNotFound > docCount then
        MessageDlg('Ada Data List yang masih kosong, silahkan lakukan Import data terlebih dahulu', mtInformation, [mbYes], 0);



      DeleteAllFilesWithExt(dmsFolder,'pdf'); //delete all files with ext
      //dwDMS.Active := true;
      FFolderMon.Folder := dmsFolder;
      vMonitoredChanges := [];
      Include(vMonitoredChanges, ctFileName);
      FFolderMon.MonitoredChanges := vMonitoredChanges;
    end
  else
    begin
      MessageDlg('folder penyimpanan DocManS tidak bisa diakses'+#13+'Hubungi IT untuk pemeriksaan lebih lanjut', mtError, [mbYes], 0);
      close;
    end;
end;

procedure TfrmDMSScanADF.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  Width := 490;
  if FFolderMon.IsActive then FFolderMon.Deactivate;
  //FFolderMon.Free;
end;

procedure TfrmDMSScanADF.FormCreate(Sender: TObject);
begin
  FFolderMon := TFolderMon.Create;
  FFolderMon.OnFolderChange := HandleFolderChange;
end;

procedure TfrmDMSScanADF.checkFile(inComingFile : TFileName);
var inFolder, newName, groupFolder, groupID : String;
    i,j : integer;
    inData : TStringList;
    tmpClbx : TCheckListBox;
begin
  Dec(cCount,1);
  inData := TStringList.Create;
  inFolder := ExtractFilePath(inComingFile);
  newName := 'dummy';
  mmLogs.Lines.Add('monitoring ' + inComingFile);

  Application.ProcessMessages;
  case pgc.ActivePage.Tag of
    1..3 :
      begin
        groupFolder := SelectSplitString(crowList.Strings[pgc.ActivePage.Tag-1],0);
        groupID     := SelectSplitString(crowList.Strings[pgc.ActivePage.Tag-1],1);

        tmpClbx := FindComponent('clbx'+groupID) as TCheckListBox;
        for i := 0 to tmpClbx.Count - 1 do
          begin
            Application.ProcessMessages;
            if tmpClbx.Checked[i] then
              begin
                j := 1;
                SplitString(inData,tmpClbx.Items.Strings[i],'|');
                newName := inFolder + groupFolder + '\' + trim(inData[1]) + '-' + groupID + '-' + LeftPad(j,2,'0') + '.pdf';
                while FileExists(newName) do
                  begin
                    Application.ProcessMessages;
                    inc(j,0);
                    newName := inFolder + groupFolder + '\' + trim(inData[1]) + '-' + groupID + '-' + LeftPad(j,2,'0') + '.pdf';
                  end;
                tmpClbx.Checked[i] := false;
                break;
              end;
          end;
      end;

    4 :
      begin
        Application.ProcessMessages;
        j := 1;
        inData.AddStrings( readScanGroup(cbxScanGrp.ItemIndex+1) );
        newName := inFolder + 'Internal\' + trim(edScanName.Text) + '-'+inData[1]+'-' + LeftPad(j,2,'0') + '.pdf';
        while FileExists(newName) do
          begin
            Application.ProcessMessages;
            inc(j,1);
            newName := inFolder + 'Internal\' + trim(edScanName.Text) + '-'+inData[1]+'-' + LeftPad(j,2,'0') + '.pdf';
          end;
      end;
  end;

  Application.ProcessMessages;
  //MoveFile(pChar(inComingFile), pChar(newName));
  FileSystemAction(FO_MOVE, inComingFile, newName);
  if (not FileExists(inComingFile) and FileExists(newName))
    then mmLogs.Lines.Add('move and renaming ' + inComingFile + ' to ' + newName)
    else mmLogs.Lines.Add('move and renaming ' + inComingFile + ' failed');

  setLog(1, trim(dm.adOTO.CurrentUserName)+' scan ADF '+newName);
  setScanTo(pgc.ActivePage.Tag,0,newName,null,0,0);
  //setMail(scMailTo, scBody, scAttach : String )

  inData.Free;
  Application.ProcessMessages;
  if cCount = 0 then
    begin
      MessageDlg('Seluruh Data telah selesai diScan', mtInformation, [mbYes], 0);
      if FFolderMon.IsActive then FFolderMon.Deactivate;
      btScan.Caption := '&Mulai Scan';
      switchAble;
    end;
end;

procedure TfrmDMSScanADF.HandleFolderChange(ASender: TFolderMon;
  AFolderItem: TFolderItemInfo);
begin
  mmLogs.Lines.Add('Item: ' + ASender.Folder + '\' + AFolderItem.Name + '; ' + FOLDER_ACTION_NAMES[AFolderItem.Action]);
  checkFile(ASender.Folder + '\' + AFolderItem.Name);
end;

procedure TfrmDMSScanADF.btImportClick(Sender: TObject);
var i : integer;
    tmpClbx : TCheckListBox;
begin
  frmDMSScanSelect.ShowModal;

  for i := 0 to crowList.Count-1 do
    begin
      if crowList.Strings[i] <> '-' then
        begin
          fileDat := ExtractFilePath(Application.ExeName) + SelectSplitString(crowList.Strings[i],1) + '.dat';
          if FileExists(fileDat) then
            begin
              tmpClbx := FindComponent('clbx'+SelectSplitString(crowList.Strings[i],1)) as TCheckListBox;
              if tmpClbx <> nil then
                begin
                  tmpClbx.Clear;
                  tmpClbx.Items.LoadFromFile(fileDat);
                end;
            end
        end;
    end;
end;

procedure TfrmDMSScanADF.btScanClick(Sender: TObject);
var i : Integer;
    tmpClbx : TCheckListBox;
begin
  cCount := 0;

  case pgc.ActivePage.Tag of
    1..3 :
      begin
        tmpClbx := FindComponent('clbx'+SelectSplitString(crowList.Strings[pgc.ActivePage.Tag-1],1)) as TCheckListBox;
        if tmpClbx <> nil then
          begin
            for i := 0 to tmpClbx.Count - 1 do
              if tmpClbx.Checked[i] then inc(cCount,1);
          end;
      end;
    4 : begin
          cCount := 1;
        end
  end;
  
  if cCount > 0 then
    begin
      if FFolderMon.IsActive then
        begin
          if MessageDlg('batalkan Scan customer ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
            begin
              FFolderMon.Deactivate;
              btScan.Caption := '&Mulai Scan';
              //switchAble;
              Width := 490;
            end;
        end
      else
        begin
          if MessageDlg('lakukan Scan sebanyak ' + IntToStr(cCount) + ' customer ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
            begin
              MessageDlg('persiapkan Lembar yang akan di Scan pastikan urutannya sesuai dengan data yang dipilih', mtInformation, [mbYes], 0);
              FFolderMon.Activate;
              btScan.Caption := '&Berhenti Scan';
              //switchAble;
              Width := 1024;
            end;
        end
    end
  else
    MessageDlg('Tolong Pilih Customer yang hendak discan', mtConfirmation, [mbYes], 0);

  ReCenter;
end;

procedure TfrmDMSScanADF.btExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmDMSScanADF.pgcChange(Sender: TObject);
begin
  if pgc.ActivePageIndex < pgc.PageCount - 1 then btAll.Visible := True else btAll.Visible := False;
  if pgc.ActivePageIndex = pgc.PageCount - 1 then OtherScanSetting;
end;

procedure TfrmDMSScanADF.btAllClick(Sender: TObject);
var i : integer;
    tmpClbx : TCheckListBox;
begin
  case pgc.ActivePage.Tag of
    1..3 :
        begin
          //ShowMessage(inttostr(pgc.ActivePage.Tag) + ' - clbx'+SelectSplitString(crowList.Strings[pgc.ActivePage.Tag],1) + #13 + crowList.Text);
          tmpClbx := FindComponent('clbx'+SelectSplitString(crowList.Strings[pgc.ActivePage.Tag-1],1)) as TCheckListBox;
          if tmpClbx <> nil then
            begin
              if tmpClbx.Items.Count > 0 then
                begin
                  for i := 0 to tmpClbx.Items.Count - 1 do
                    tmpClbx.Checked[i] := not tmpClbx.Checked[i];
                end;
            end;
        end;
    4 : begin
          MessageDlg('What ?', mtError, [mbYes], 0);
        end;
  end;
end;

procedure TfrmDMSScanADF.chbxIsRreminderClick(Sender: TObject);
begin
  grbxReminder.Enabled := chbxIsRreminder.Checked;
end;

procedure TfrmDMSScanADF.cbxScanGrpKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = chr(VK_RETURN) then
    begin
      Key := #0;
      Perform(WM_NEXTDLGCTL,0,0);
    end;
end;

procedure TfrmDMSScanADF.edScanNameExit(Sender: TObject);
begin
  if trim(edScanName.Text) = '' then
    begin
      MessageDlg('Nama File tidak boleh kosong', mtError, [mbYes],0);
      edScanName.SetFocus;
    end;
end;

procedure TfrmDMSScanADF.chbxRemindOnceKeyPress(Sender: TObject;
  var Key: Char);
begin
{}
end;

procedure TfrmDMSScanADF.edBulanExit(Sender: TObject);
var iValue, iCode: Integer;
begin
  val(edBulan.Text, iValue, iCode);
  if iCode = 0
    then dtpRemindWhen.Date := IncMonth(date,StrToInt(edBulan.Text))
    else ShowMessage('bukan ANGKA !');
end;

procedure TfrmDMSScanADF.chbxIsRreminderExit(Sender: TObject);
begin
  if chbxIsRreminder.Checked = false then btScanClick(self);
end;

procedure TfrmDMSScanADF.chbxRemindOnceExit(Sender: TObject);
begin
  btScanClick(self);
end;

procedure TfrmDMSScanADF.edSCOPKeyPress(Sender: TObject; var Key: Char);
var i : integer;
    tmpClbx : TCheckListBox;
begin
  if key = chr(vk_return) then
    begin
      key := #0;

      tmpClbx := FindComponent('clbx'+SelectSplitString(crowList.Strings[pgc.ActivePage.Tag-1],1)) as TCheckListBox;
      if tmpClbx <> nil then
        begin
          if tmpClbx.Items.Count > 0 then
            begin
              for i := 0 to tmpClbx.Items.Count - 1 do
                if pos(LowerCase((Sender as TEdit).Text), LowerCase(tmpClbx.Items.Strings[i])) > 0 then
                  begin
                    tmpClbx.Checked[i] := true;
                  end;
            end;
        end;

    end;
end;

end.
