unit unDMSScanFB;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DelphiTwain, ExtCtrls, StdCtrls, Buttons, DBCtrls, CheckLst,
  ComCtrls;

type
  TfrmDMSScanFB = class(TForm)
    twain: TDelphiTwain;
    Panel1: TPanel;
    Panel2: TPanel;
    btImport: TSpeedButton;
    btScan: TSpeedButton;
    btExit: TSpeedButton;
    pnScan: TPanel;
    ContainImage: TScrollBox;
    ImageResult: TImage;
    pnv: TPanel;
    lbi: TLabel;
    lbno: TLabel;
    lbnm: TLabel;
    SpeedButton1: TSpeedButton;
    dbtno: TLabel;
    dbtnm: TLabel;
    chbxa: TCheckBox;
    pna: TPanel;
    btsc: TSpeedButton;
    btpdf: TSpeedButton;
    btd: TSpeedButton;
    btr: TSpeedButton;
    btAll: TSpeedButton;
    pgc: TPageControl;
    tbsCOP: TTabSheet;
    clbxCOP: TCheckListBox;
    pnSCOP: TPanel;
    edSCOP: TEdit;
    tbsBPK: TTabSheet;
    clbxBPK: TCheckListBox;
    pnSBPK: TPanel;
    edSBPK: TEdit;
    tbsOLease: TTabSheet;
    pnSOLE: TPanel;
    edSOLE: TEdit;
    clbxOLE: TCheckListBox;
    tbsOther: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    cbxScanGrp: TComboBox;
    edScanName: TEdit;
    chbxIsRreminder: TCheckBox;
    grbxReminder: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edBulan: TEdit;
    udBulan: TUpDown;
    dtpRemindWhen: TDateTimePicker;
    chbxRemindOnce: TCheckBox;
    procedure ReCenter;
    procedure OtherScanSetting;
    Procedure SaveTmpPict;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btImportClick(Sender: TObject);
    procedure btScanClick(Sender: TObject);
    procedure btExitClick(Sender: TObject);
    procedure btscClick(Sender: TObject);
    procedure btdClick(Sender: TObject);
    procedure btrClick(Sender: TObject);
    procedure btpdfClick(Sender: TObject);
    procedure twainSourceFileTransfer(Sender: TObject;
      const Index: Integer; Filename: TW_STR255; Format: TTwainFormat;
      var Cancel: Boolean);
    procedure twainSourceSetupFileXfer(Sender: TObject;
      const Index: Integer);
    procedure twainTwainAcquire(Sender: TObject; const Index: Integer;
      Image: TBitmap; var Cancel: Boolean);
    procedure chbxaClick(Sender: TObject);
    procedure pgcChange(Sender: TObject);
    procedure btAllClick(Sender: TObject);
    procedure cbxScanGrpKeyPress(Sender: TObject; var Key: Char);
    procedure edScanNameExit(Sender: TObject);
    procedure chbxIsRreminderClick(Sender: TObject);
    procedure edBulanExit(Sender: TObject);
    procedure chbxRemindOnceExit(Sender: TObject);
    procedure chbxIsRreminderExit(Sender: TObject);
  private
    CurrentSource: Integer;
    //twsource : TTwainSource;
    docgroup : TStringList;
    isLide : Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

const
  dtmp = 'd:\txmp';



var
  frmDMSScanFB: TfrmDMSScanFB;
  dmsFolder : String;
  cCount : Integer;
  fileDat: TFileName;
  docCount : Integer;
  svrLayOut, crowList : TStringList;

implementation

uses GenericFP,ImageLib, unDMSScanSelect, unDocManSData,
  unDMSScanFBProccess;

{$R *.dfm}

procedure TfrmDMSScanFB.ReCenter;
var
  LRect: TRect;
  X, Y: Integer;
begin
  LRect := Screen.WorkAreaRect;
  X := LRect.Left + (LRect.Right - LRect.Left - Width) div 2;
  Y := LRect.Top + (LRect.Bottom - LRect.Top - Height) div 2;
  SetBounds(X, Y, Width, Height);
end;

procedure TfrmDMSScanFB.OtherScanSetting;
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

Procedure TfrmDMSScanFB.SaveTmpPict;
var tmpf : String;
begin
  tmpf := dtmp + '\i.bmp';

  ImageResult.Picture.SaveToFile(tmpf);
  SetBMPFileDPI(tmpf,50);

  ImageResult.Picture.Bitmap.PixelFormat := pf8bit;
  ImageResult.Picture.Bitmap.LoadFromFile(tmpf);

  bmp2jpg(tmpf,ChangeFileExt(tmpf, '.jpg'),30,0,90,30,50);

  DeleteFile(tmpf);
  ShowMessage('ready');
end;

procedure TfrmDMSScanFB.FormShow(Sender: TObject);
var svrData,svrFolder,usrName, usrSalt : String;
    iTry, eco, fileNotFound, i, NewSource : integer;
    isOK : Boolean;
    tmpClbx : TCheckListBox;
begin
  Width := 490;
  svrData := getDBConfig(5);
  svrFolder := getDBConfig(6);
  usrName := getDBConfig(8);
  usrSalt := getDBConfig(9);

  dmsFolder := '\\' + svrData + '\' + svrFolder;
  isOK := false;
  
  if pgc.ActivePageIndex = pgc.PageCount - 1 then OtherScanSetting;

  svrLayOut := TStringList.Create;
  svrLayOut := getLayOut(StrToInt(getDBConfig(1)));
  docCount := StrToInt(svrLayOut.Strings[8]);

  crowList := TStringList.Create;
  crowList := docLayOut(svrLayOut);

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
    end
  else
    begin
      MessageDlg('folder penyimpanan DocManS tidak bisa diakses'+#13+'Hubungi IT untuk pemeriksaan lebih lanjut', mtError, [mbYes], 0);
      close;
    end;

  //----------------------------------------------------------------------------

  ImageResult.Picture := nil;
  //tdir := lbdp.Caption + '\Scanned\'+pna.Caption;
  //ShowMessage(tdir);
  docgroup := TStringList.Create;
  //docgroup.Duplicates := dupIgnore;

  isLide := False;

  //check standar folder
  if DirectoryExists(dtmp) then DeleteAllFilesWithExt(dtmp,'*')
                           else ForceDirectories(dtmp);

  //Check Scanner
  if Twain.LoadLibrary then
    begin
      Twain.LoadSourceManager;

      if Twain.SourceManagerLoaded then
        begin
          NewSource := Twain.SelectSource;
          {In case some source was choosen}
          if NewSource <>-1 then
            begin
              CurrentSource := NewSource;
              // ListSources.ItemIndex := CurrentSource;
            end {if NewSource <>-1}
        end
      else
        begin
        {Manually loading source}
        if Twain.LoadLibrary then
          begin
            {Load twain, show interface to select source and unload}
            Twain.LoadSourceManager;
            NewSource := Twain.SelectSource;
            if NewSource <>-1 then CurrentSource := NewSource;
            Twain.UnloadLibrary;
          end
        else
          ShowMessage('Library could not be loaded, check if source is loaded')
      end; {if Twain.SourceManagerLoaded}

      if CurrentSource > 0 then
        begin
          twain.Source[CurrentSource].Loaded := True;
          if pos('LiDE', twain.Source[CurrentSource].ProductName) > 0 then isLide := True;
          twain.Source[CurrentSource].SetIBitDepth(8);
        end
      else
        begin
          MessageDlg('Scanner tidak ditemukan', mtError, [mbCancel], 0);
          close;
        end;
      twain.UnloadSourceManager(false);
      twain.UnloadLibrary;
      tag := 0;
    end
  else
    begin
      ShowMessage('Tolong periksa Scanner');
      Close;
    end;
end;

procedure TfrmDMSScanFB.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if DirectoryExists(dtmp) then DeleteAllFilesWithExt(dtmp,'*');
  docgroup.Free;
  Width := 490;
end;

procedure TfrmDMSScanFB.btImportClick(Sender: TObject);
begin
  frmDMSScanSelect.ShowModal;
end;

procedure TfrmDMSScanFB.btScanClick(Sender: TObject);
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
      if pnScan.Enabled then
        begin
          if MessageDlg('batalkan Scan customer ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
            begin
              pnScan.Enabled := false;
              btScan.Caption := '&Mulai Scan';
              //switchAble;
              Width := 490;
            end;
        end
      else
        begin
          if MessageDlg('lakukan Scan sebanyak ' + IntToStr(cCount) + ' customer ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
            begin
              MessageDlg('persiapkan Lembar yang akan di Scan' + 'pastikan urutannya sesuai dengan data yang dipilih', mtInformation, [mbYes], 0);
              pnScan.Enabled   := True;
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

procedure TfrmDMSScanFB.btExitClick(Sender: TObject);
begin
  close;
end;

procedure TfrmDMSScanFB.btscClick(Sender: TObject);
begin
  ImageResult.Picture := nil;
  tag := 1;

  {Load library, source manager and source}
  Twain.LoadLibrary;
  Twain.LoadSourceManager;
  Twain.Source[CurrentSource].Loaded := TRUE;
  {Enable source}
  Twain.Source[CurrentSource].TransferMode := ttmMemory;
  //Twain.Source[CurrentSource].EnableSource(isLide, FALSE);
  Twain.Source[CurrentSource].EnableSource(TRUE, FALSE);
  while Twain.Source[CurrentSource].Enabled do Application.ProcessMessages;
  {Unload library}
  Twain.UnloadLibrary;

  {Save Temp Pict}
  SaveTmpPict;
end;

procedure TfrmDMSScanFB.btdClick(Sender: TObject);
begin
  DeleteAllFilesWithExt(dtmp,'*');
  ImageResult.Picture := nil;
end;

procedure TfrmDMSScanFB.btrClick(Sender: TObject);
var
 lRadians : real;
 DC  : longint;
 H, W : integer;
 Degrees : integer;
begin
  Degrees := 90;
  lRadians := PI * Degrees / 180;
  DC := ImageResult.Picture.Bitmap.Canvas.Handle;
  H := ImageResult.Picture.Bitmap.Height;
  W := ImageResult.Picture.Bitmap.Width;
  RotateBitmap(DC, W, H, lRadians);
  ImageResult.Width := W;
  ImageResult.Height := H;
  ImageResult.Picture.Bitmap.Width := W;
  ImageResult.Picture.Bitmap.Height := H;
  BitBlt(ImageResult.Picture.Bitmap.Canvas.Handle, 0, 0, W, H, DC, 0, 0, SRCCopy);
  ImageResult.Refresh;
  SaveTmpPict
end;

procedure TfrmDMSScanFB.btpdfClick(Sender: TObject);
var nimg : TIMage;
    svrBranch, newName, groupFolder, groupID : String;
    i,j : integer;
    inData : TStringList;
    tmpClbx : TCheckListBox;
begin
  Dec(cCount,1);
  svrBranch := getDBConfig(3);
  inData := TStringList.Create;
  newName := 'dummy';

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
                newName := dmsFolder + groupFolder + '\' + trim(inData[0]) + '-' + groupID + '-' + LeftPad(j,2,'0') + '.pdf';
                while FileExists(newName) do
                  begin
                    Application.ProcessMessages;
                    inc(j,0);
                    newName := dmsFolder + groupFolder + '\' + trim(inData[0]) + '-' + groupID + '-' + LeftPad(j,2,'0') + '.pdf';
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
        inData.AddStrings( readScanGroup(cbxScanGrp.ItemIndex) );
        newName := dmsFolder + 'Internal\' + trim(edScanName.Text) + '-'+inData[1]+'-' + LeftPad(j,2,'0') + '.pdf';
        while FileExists(newName) do
          begin
            Application.ProcessMessages;
            inc(j,1);
            newName := dmsFolder + 'Internal\' + trim(edScanName.Text) + '-'+inData[1]+'-' + LeftPad(j,2,'0') + '.pdf';
          end;
      end;
  end;
//-------------------------------------------------------------------------------
  if tag = 1 then
    begin
      if MessageDlg('apakah ada data akan disimpan ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        begin
          tag := 2;
          nimg := TImage.Create(self);
          frmDMSScanFBProccess.PReport1.Author   := svrLayOut.Strings[0];
          frmDMSScanFBProccess.PReport1.Creator  := svrBranch + ' ' + dm.adOTO.CurrentUserName; //isi KdCabang + Nama PIC
          frmDMSScanFBProccess.PReport1.Subject  := inData[1];                            //Isi dengan No Kontrak
          frmDMSScanFBProccess.PReport1.Title    := inData[0];                            //Isi dengan Nama Kontrak
          frmDMSScanFBProccess.PReport1.FileName := newName;
          case pgc.ActivePage.Tag of
          1 : begin
                frmDMSScanFBProccess.PReport1.Keywords := svrLayOut.Strings[0] + #13 +
                                                    'Cabang : ' + svrBranch + #13 +
                                                    'No.Kontrak : ' + trim(inData[1]) + #13 +
                                                    'a/n : ' + trim(inData[0]);
              end;
          2 : begin
                frmDMSScanFBProccess.PReport1.Keywords := svrLayOut.Strings[0] + #13 +
                                                    'Cabang : ' + svrBranch + #13 +
                                                    'No.Kontrak : ' + trim(inData[1]) + #13 +
                                                    'a/n : ' + trim(inData[0]);
              end;
          3 : begin
                frmDMSScanFBProccess.PReport1.Keywords := svrLayOut.Strings[0] + #13 +
                                                    'Cabang : ' + svrBranch + #13 +
                                                    'Lease No : ' + trim(inData[0]) + #13 +
                                                    'Cust Code : ' + trim(inData[1]);
              end;
          4 : begin
                frmDMSScanFBProccess.PReport1.Keywords := svrLayOut.Strings[0] + #13 +
                                                    'Group : ' + inData[1];
              end;
          end;
          //ScanToProccess.ShowModal;
          frmDMSScanFBProccess.PReport1.BeginDoc;
          nimg.Picture.LoadFromFile(dtmp + '\i.jpg');                                                                                        
          frmDMSScanFBProccess.PReport1.EndDoc;

          tag := 0;
          ImageResult.Picture := nil;
          nimg.Free;

          setLog(1, trim(dm.adOTO.CurrentUserName)+' scan FB '+newName);
          setScanTo(pgc.ActivePage.Tag,0,newName,null,0,0);
          //setMail(scMailTo, scBody, scAttach : String )

          ShowMessage('File Sudah disimpan');
        end;
    end
  else ShowMessage('Lakukan Scan Dokumen terlebih dahulu');
//------------------------------------------------------------------------------

  inData.Free;
  Application.ProcessMessages;
  if cCount = 0 then
    begin
      MessageDlg('Seluruh Data telah selesai diScan', mtInformation, [mbYes], 0);
      if pnScan.Enabled then pnScan.Enabled := false;
      btScan.Caption := '&Mulai Scan';
      //switchAble;
    end;

  //--------------------------------------------------------------------------------------------
end;

procedure TfrmDMSScanFB.twainSourceFileTransfer(Sender: TObject;
  const Index: Integer; Filename: TW_STR255; Format: TTwainFormat;
  var Cancel: Boolean);
var LoadFileName: String;
begin
  LoadFileName := dtmp + '\i.bmp';
  ImageResult.Picture.LoadFromFile(LoadFilename);
  DeleteFile(LoadFileName);
end;

procedure TfrmDMSScanFB.twainSourceSetupFileXfer(Sender: TObject;
  const Index: Integer);
begin
  Twain.Source[Index].SetupFileTransfer(dtmp + '\i.bmp', tfBmp);
end;

procedure TfrmDMSScanFB.twainTwainAcquire(Sender: TObject;
  const Index: Integer; Image: TBitmap; var Cancel: Boolean);
begin
  TBitmap.Create;
  TBitmap(ImageResult.Picture).Assign(Image);
end;

procedure TfrmDMSScanFB.chbxaClick(Sender: TObject);
begin
  if chbxa.Checked then
    begin
      ImageResult.AutoSize := False;
      ImageResult.Stretch  := True;
      ImageResult.Width  := ContainImage.Width - 4;
      ImageResult.Height := ContainImage.Height - 4;
    end
  else
    begin
      ImageResult.AutoSize := True;
      ImageResult.Stretch  := False;
    end;
end;

procedure TfrmDMSScanFB.pgcChange(Sender: TObject);
begin
  if pgc.ActivePageIndex < 2 then btAll.Visible := True else btAll.Visible := False;
end;

procedure TfrmDMSScanFB.btAllClick(Sender: TObject);
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

procedure TfrmDMSScanFB.cbxScanGrpKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = chr(VK_RETURN) then
    begin
      Key := #0;
      Perform(WM_NEXTDLGCTL,0,0);
    end;
end;

procedure TfrmDMSScanFB.edScanNameExit(Sender: TObject);
begin
  if trim(edScanName.Text) = '' then
    begin
      MessageDlg('Nama File tidak boleh kosong', mtError, [mbYes],0);
      edScanName.SetFocus;
    end;
end;

procedure TfrmDMSScanFB.chbxIsRreminderClick(Sender: TObject);
begin
  grbxReminder.Enabled := chbxIsRreminder.Checked;
end;

procedure TfrmDMSScanFB.edBulanExit(Sender: TObject);
var iValue, iCode: Integer;
begin
  val(edBulan.Text, iValue, iCode);
  if iCode = 0
    then dtpRemindWhen.Date := IncMonth(date,StrToInt(edBulan.Text))
    else ShowMessage('bukan ANGKA !');
end;

procedure TfrmDMSScanFB.chbxRemindOnceExit(Sender: TObject);
begin
  btScanClick(self);
end;

procedure TfrmDMSScanFB.chbxIsRreminderExit(Sender: TObject);
begin
  if chbxIsRreminder.Checked = false then btScanClick(self);
end;

end.
