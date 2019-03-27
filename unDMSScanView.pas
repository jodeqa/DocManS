unit unDMSScanView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, OleCtrls, AcroPDFLib_TLB, StdCtrls, FileCtrl, Buttons,
  ExtCtrls,ComObj, ActiveX;

type
  TfrmDMSScanView = class(TForm)
    pnv: TPanel;
    lbi: TLabel;
    lbg: TLabel;
    lbcr: TLabel;
    btsrc: TSpeedButton;
    lbdp: TLabel;
    cbxg: TComboBox;
    edcr: TEdit;
    pna: TPanel;
    btx: TSpeedButton;
    btp: TSpeedButton;
    btd: TSpeedButton;
    btm: TSpeedButton;
    btq: TSpeedButton;
    btf: TSpeedButton;
    flbx: TFileListBox;
    AcroPDF1: TAcroPDF;
    ppmnuCetak: TPopupMenu;
    N2Panel1: TMenuItem;
    N4Panel1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edcrKeyPress(Sender: TObject; var Key: Char);
    procedure btsrcClick(Sender: TObject);
    procedure btpClick(Sender: TObject);
    procedure btqClick(Sender: TObject);
    procedure btdClick(Sender: TObject);
    procedure btmClick(Sender: TObject);
    procedure btfClick(Sender: TObject);
    procedure btxClick(Sender: TObject);
    procedure N2Panel1Click(Sender: TObject);
    procedure flbxClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDMSScanView: TfrmDMSScanView;
  dmsFolder : String;
  docCount : Integer;
  svrLayOut, crowList : TStringList;

implementation

uses unDocManSData, GenericFP, unDMSPrintDual, unDMSPrintQuatro;

{$R *.dfm}

function IsObjectActive(ClassName: string): Boolean;
var
  ClassID: TCLSID;
  Unknown: IUnknown;
begin
  try
    ClassID := ProgIDToClassID(ClassName);
    Result  := GetActiveObject(ClassID, nil, Unknown) = S_OK;
  except
    // raise;
    Result := False;
  end;
end;

function FindFiles(var flist,clist : TStringlist; const Path, Mask: string; IncludeSubDir: boolean): integer;
var 
 FindResult: integer;
 SearchRec : TSearchRec;
 splitname : TStringList;
 sfn,spfn  : string;
begin
 splitname := TStringList.Create;
 result := 0;

 FindResult := FindFirst(Path + Mask, faAnyFile - faDirectory, SearchRec);
 while FindResult = 0 do
   begin
     { do whatever you'd like to do with the files found }
     splitname.Clear;
     sfn  := Path + SearchRec.Name;
     spfn := sfn;
     Delete(spfn,1,length(Path));
     //Split('\',spfn,splitname);
     sfn := DateTimeToStr(GetFileDateTime(sfn));
     flist.Add(Format('%-40.40s %-20.20s', [spfn, sfn]));
     clist.Add(copy(spfn,1,15));
     result := result + 1;

     FindResult := FindNext(SearchRec); 
   end; 
 { free memory } 
 FindClose(SearchRec); 

 if not IncludeSubDir then 
   Exit; 

 FindResult := FindFirst(Path + '*.*', faDirectory, SearchRec); 
 while FindResult = 0 do 
 begin 
   if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
     result := result + 
       FindFiles (flist,clist,Path + SearchRec.Name + '\', Mask, TRUE);

   FindResult := FindNext(SearchRec); 
 end; 
 { free memory } 
 FindClose(SearchRec);
end;

procedure TfrmDMSScanView.FormShow(Sender: TObject);
var svrData,svrFolder,svrBranch, usrName, usrSalt : String;
    isOK : Boolean;
    iTry, eco : integer;
begin
  setLog(2, trim(dm.adOTO.CurrentUserName)+' Open View');

  svrBranch := getDBConfig(3);
  svrData := getDBConfig(5);
  svrFolder := getDBConfig(6);
  usrName := getDBConfig(8);
  usrSalt := getDBConfig(9);

  dmsFolder := '\\' + svrData + '\' + svrFolder;
  isOK := false;

  svrLayOut := TStringList.Create;
  svrLayOut := getLayOut(StrToInt(getDBConfig(1)));
  docCount := StrToInt(svrLayOut.Strings[8]);

  cbxg.Clear;
  for iTry := 3 to 6 do //isCOP, isBPK, isOLE, isInt
    begin
      if svrLayOut.Strings[iTry] <> '0'
         then cbxg.Items.Add((getGroup(iTry-2)).Strings[0]);
    end;
  cbxg.ItemIndex := 0;

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
    end
  else
    begin
      MessageDlg('folder penyimpanan DocManS tidak bisa diakses'+#13+'Hubungi IT untuk pemeriksaan lebih lanjut', mtError, [mbYes], 0);
      close;
    end;
end;

procedure TfrmDMSScanView.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  {};
end;

procedure TfrmDMSScanView.edcrKeyPress(Sender: TObject; var Key: Char);
begin
  if key = chr(VK_RETURN) then
    begin
      key := #0;
      flbx.Directory := dmsFolder + '\' + cbxg.Text;
      flbx.Mask := cbxg.Text + '-' + edcr.Text + '*.pdf';
      AcroPDF1.Visible := False;
    end;
end;

procedure TfrmDMSScanView.btsrcClick(Sender: TObject);
var key : char;
begin
  key := chr(VK_RETURN);
  edcrKeyPress(sender,key);
end;

procedure TfrmDMSScanView.btpClick(Sender: TObject);
begin
  setLog(3, trim(dm.adOTO.CurrentUserName)+' Printing '+flbx.FileName);
  if (AcroPDF1.src <> '') and (AcroPDF1.Visible) then AcroPDF1.Print; //AcroPDF1.printWithDialog;
end;

procedure TfrmDMSScanView.btqClick(Sender: TObject);
var pt : TPoint;
begin
  //pt.X := btq.ClientRect.Left + 1;
  //pt.y := btq.ClientRect.Top + btq.Height + 1;
  if GetCursorPos( pt ) then
  //pt := Self.ClientToScreen( pt );
    ppmnuCetak.Popup( pt.X, pt.Y-20 );
  //ScanToViewQuatro.showmodal;
end;

procedure TfrmDMSScanView.btdClick(Sender: TObject);
begin
  if flbx.FileName <> '' then
    begin
      if MessageDlg('hapus file ' + ExtractFileName( flbx.FileName ) + ' ?', mtWarning, [mbYes, mbNo], 0) = mrYes then
        DeleteFile(flbx.FileName);
    end;
end;

procedure TfrmDMSScanView.btmClick(Sender: TObject);
const olMailItem = 0;
var Outlook, MailItem: OLEVariant;
begin
  if flbx.FileName <> '' then
    begin
      if IsObjectActive('Outlook.Application') then
        begin
          Outlook := CreateOleObject('Outlook.Application');
          MailItem := Outlook.CreateItem(olMailItem);
          MailItem.Recipients.Add(dm.adOTO.CurrentUserName + '@oto.co.id');
          MailItem.Subject := ExtractFileName(flbx.FileName);
          MailItem.Body := 'Dengan Hormat,' + #13 +  #13 + 'Berikut kami kirimkan file ' + ExtractFileName(flbx.FileName) +
                           #13 +  #13 + 'Terima kasih.' + #13 + dm.adOTO.CurrentUserName;
          MailItem.Attachments.Add(flbx.FileName);
          MailItem.Display;
          Outlook := Unassigned;
        end
      else ShowMessage('Aplikasi Outlook harus berjalan untuk bisa mengirimkan email');
    end;
end;

procedure TfrmDMSScanView.btfClick(Sender: TObject);
var slfilelist,slcontlist : TStringList;
    clsv     : string;
    svdflist : TSaveDialog;
    //fcount   : Integer;
begin
  slfilelist := TStringList.Create;

  slcontlist := TStringList.Create;
  slcontlist.Sorted := true;
  slcontlist.Duplicates := dupIgnore;

  svdflist   := TSaveDialog.Create(self);
  svdflist.DefaultExt := '*.txt';
  svdflist.Filter := 'File Text (*.txt)|*.TXT';
  svdflist.InitialDir := ExtractFilePath( Application.ExeName );

  //fcount := FindFiles(slfilelist,slcontlist,flbx.Directory,'*.pdf',true);
  if svdflist.Execute then
    begin
      slfilelist.SaveToFile(svdflist.FileName);
      //clsv := ChangeFileExt(svdflist.FileName,'.DAT');
      clsv := ExtractFilePath( Application.ExeName ) + 'scanlog.dat';
      slcontlist.SaveToFile(clsv);
    end;
end;

procedure TfrmDMSScanView.btxClick(Sender: TObject);
begin
  close;
end;

procedure TfrmDMSScanView.N2Panel1Click(Sender: TObject);
begin
  setLog(3, trim(dm.adOTO.CurrentUserName)+' Printing Panel '+flbx.FileName);
  case (sender as TMenuItem).Tag of
    0 : frmDMSPrintDual.ShowModal;
    1 : frmDMSPrintQuatro.ShowModal;
  end;
end;

procedure TfrmDMSScanView.flbxClick(Sender: TObject);
begin
  if FileExists(flbx.FileName) then
    begin
      //AcroPDF1.src := flbx.FileName;
      if MessageDlg('apakah hendak melihat file dulu ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        begin
          setLog(2, trim(dm.adOTO.CurrentUserName)+' Viewing '+flbx.FileName);
          AcroPDF1.LoadFile(flbx.FileName);
          AcroPDF1.setView('fitbv');
          AcroPDF1.setShowScrollbars(False);
          AcroPDF1.setShowToolbar(False);
          AcroPDF1.Visible := True;
        end
      else btxClick(sender);
    end;
end;

end.
