unit unDMSScanSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, Buttons, ComCtrls, STrUtils, ExtCtrls, ComObj, GifImage,
  Gauges;

type
  TfrmDMSScanSelect = class(TForm)
    btImportData: TSpeedButton;
    btSelesai: TSpeedButton;
    pgc: TPageControl;
    tbsCOP: TTabSheet;
    tbsBPK: TTabSheet;
    pnCOP: TPanel;
    pnBPK: TPanel;
    lsbCOP: TListBox;
    lsbBPK: TListBox;
    pnPlzWait: TPanel;
    tbsOLE: TTabSheet;
    lsbOLE: TListBox;
    pnOLE: TPanel;
    imgWait: TImage;
    lbWait: TLabel;
    gauData: TGauge;
    procedure SaveAsDB(ls : TLIstBox; fts : TFileName);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btSelesaiClick(Sender: TObject);
    procedure btImportDataClick(Sender: TObject);
    procedure lsbCOPDblClick(Sender: TObject);
  private
    { Private declarations }
    procedure proccessCOPCSV(xlsName:TFileName; chbx : TListBox);
    procedure ImportCOP;
    procedure proccessBPKCSV(xlsName:TFileName; chbx : TListBox);
    procedure ImportBPK;
    procedure proccessOLECSV(xlsName:TFileName; chbx : TListBox);
    procedure ImportOLE;
  public
    { Public declarations }
  end;

const
  xlCSV = $00000006;

var
  frmDMSScanSelect: TfrmDMSScanSelect;
  fileDat: TFileName;
  docCount : Integer;
  svrLayOut, crowList : TStringList;

implementation

uses GenericFP, unDocManSData, unDMSScanSelectEdit;

{$R *.dfm}

function EscapeCSVString(s: string; const delimiter: Char = ','; const enclosure: Char = '"'): string;
begin
    Result := StringReplace(s,enclosure,enclosure+enclosure,[rfReplaceAll]);
    if (Pos(delimiter,s) > 0) OR (Pos(enclosure,s) > 0) then
        Result := enclosure+Result+enclosure;
end;

function SNL_FileTime2DateTime(FileTime: TFileTime): TDateTime;
var
   LocalFileTime: TFileTime;
   SystemTime: TSystemTime;
begin
   FileTimeToLocalFileTime(FileTime, LocalFileTime) ;
   FileTimeToSystemTime(LocalFileTime, SystemTime) ;
   Result := SystemTimeToDateTime(SystemTime) ;
end;

function GetFileCreationTime(FileName: string): TDateTime;
var
   MyRec: TSearchRec;
begin
   Result := Now;

   if (FindFirst(FileName, faAnyFile, MyRec) = 0) then
   begin
      Result := SNL_FileTime2DateTime(MyRec.FindData.ftCreationTime);
      FindClose(MyRec);
   end;
end;

procedure TfrmDMSScanSelect.proccessCOPCSV(xlsName:TFileName; chbx : TListBox);
var tsr,rowData : TStringList;
    csvName : TFileName;
    i : integer;
begin
  tsr := TStringList.Create;
  rowData := TStringList.Create;
  csvName := ChangeFileExt(xlsName, '.csv');

  if FileExists(csvName) then
    begin
      tsr.LoadFromFile(csvName);
      gauData.MinValue := 1;
      gauData.MaxValue := tsr.Count;
      for i := 1 to tsr.Count - 1 do
        begin
          rowData.Text := AnsiReplaceStr(tsr.Strings[i],',',#13#10);
          gauData.Progress := i;
          Application.ProcessMessages;
          try
            chbx.Items.Add(rowData[1] + ' | ' + rowData[2] + ' | ' + rowData[4]);
          except
            on E : Exception do
              begin
                chbx.Items.Add(tsr.Strings[i]);
              end;
          end;
          //ListBox1.Items.Add(IntToStr(i) + ' -> ' + tsr.Strings[i]);
        end;
    end;
end;

procedure TfrmDMSScanSelect.ImportCOP;
var opd : TOpenDialog;
    ts, tr : TStringList;
    crow : AnsiString;
    xls, xlw: Variant;
    fn : TFileName;
    i : integer;
begin
  opd := TOpenDialog.Create(self);
  opd.Title := 'Import Commence Contract List';
  opd.InitialDir := GetCurrentDir;
  opd.Options := [ofFileMustExist];
  opd.Filter := 'Excel Files|*.xls';
  opd.DefaultExt := 'xls';
  lsbCOP.Clear;

  ts := TStringList.Create;
  tr := TStringList.Create;

  if (opd.Execute) and (opd.FileName <> '') then
    begin
      pnPlzWait.Visible := true;
      lbWait.Caption := 'Convert XLS to CSV';
      imgWait.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'wait.gif');
      gauData.Progress := 0;
      Application.ProcessMessages;
      fn := opd.FileName;
      xls := CreateOleObject('Excel.Application');
      xlw := xls.WorkBooks.Open(fn);
      fn := ChangeFileExt(opd.FileName,'.csv');
      xlw.SaveAs(fn, xlCSV);
      lbWait.Caption := 'Convert Done';
      Application.ProcessMessages;
      xlw.Close;
      xlw := UnAssigned;
      xls.Quit;
      xls := UnAssigned;

      lbWait.Caption := 'Crow Header';
      Application.ProcessMessages;
      ts.LoadFromFile(fn);
      crow := 'No.,,Customer Name,, Contract No,,,,Approval Date,Commence Process Date,,Installment Due Date,,,Dealer,,Brand /Asset Condition/Type/Asset Description,,,OTR/DP Amount/Percentage,,,Total DP Amount/ PO Amount,,,,,Tenor,Interest Rate,Receivable,,Maskapai / ';
      crow := crow + 'Coverage Type / Selling Ins Rate / Standart Ins Rate,MO,CrH,Package Code,';
      tr.Append(crow);
      lbWait.Caption := 'replacing body';
      Application.ProcessMessages;
      for i := 13 to ts.Count - 1 do
        begin
          crow := '';
          crow := StringReplace(ts.Strings[i], ',,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,', '', [rfReplaceAll, rfIgnoreCase]);
          crow := StringReplace(crow, ' / ', ',', [rfReplaceAll, rfIgnoreCase]);
          crow := StringReplace(crow, ',/,', ',', [rfReplaceAll, rfIgnoreCase]);
          if pos('Printed By',crow) = 0 then tr.Append(crow);
        end;

      for i := tr.Count - 1 downto 0 do
        begin
          if Trim(tr.Strings[i]) = '' then tr.Delete(i);
          lbWait.Caption := 'Processing '+intToStr(tr.Count)+' lines';
          Application.ProcessMessages;
        end;

      tr.SaveToFile(fn);
      lbWait.Caption := 'Processing DECC';
      Application.ProcessMessages;
      ExeDOSAndWait(ExtractFilePath(Application.ExeName) + 'decc.exe ' + fn + ' tmp.csv', SW_HIDE);
      ExeDOSAndWait(ExtractFilePath(Application.ExeName) + 'decc.exe tmp.csv ' + fn, SW_HIDE);
      lbWait.Caption := 'Processing CSV';
      Application.ProcessMessages;
      proccessCOPCSV(opd.FileName, lsbCOP);
      lbWait.Caption := 'Done';
      Application.ProcessMessages;

    end;

  opd.Free;
  ts.Free;
  tr.Free;

  fileDat := ExtractFilePath(Application.ExeName) + SelectSplitString(crowList.Strings[pgc.ActivePage.Tag-1],1) + '.dat';
  SaveAsDB(lsbCOP,fileDat);
  pnPlzWait.Visible := false;
end;

procedure TfrmDMSScanSelect.proccessBPKCSV(xlsName:TFileName; chbx : TListBox);
var tsr,rowData : TStringList;
    csvName : TFileName;
    i : integer;
    strSentinel, strInBound : String;
    inBound : Boolean;
begin
  tsr := TStringList.Create;
  rowData := TStringList.Create;
  csvName := ChangeFileExt(xlsName, '.csv');
  strSentinel := 'Transaction : Accepted';
  inBound := False;
  strInBound := 'false';
  //ListBox1.Clear;
  if FileExists(csvName) then
    begin
      tsr.LoadFromFile(csvName);
      gauData.MinValue := 1;
      gauData.MaxValue := tsr.Count;
      for i := 1 to tsr.Count - 1 do
        begin
          gauData.Progress := i;
          Application.ProcessMessages;
          try
            if Copy(tsr.Strings[i],0,11) = Copy(strSentinel,0,11) then
               if (Copy(tsr.Strings[i],0,22) = strSentinel) then inBound := True else inBound := False;
            if inBound and (Copy(tsr.Strings[i],0,22) <> strSentinel) then
              begin
                rowData.Clear;
                rowData.AddStrings(ParseCSVString(tsr.Strings[i],',','"'));
                //chbx.Items.Add(rowData.Strings[1] + ' | ' + rowData.Strings[2] + ' | ' + rowData.Strings[9] + ' | ' + rowData.Strings[11]);
                chbx.Items.Add(rowData.Strings[1] + ' | ' + rowData.Strings[2] + ' | ' + rowData.Strings[11]);
              end;
            if inBound then strInBound := 'true' else strInBound := 'false';
          except
            on E : Exception do
              begin
                chbx.Items.Add(tsr.Strings[i]);
              end;
          end;
        end;
    end;
end;

procedure TfrmDMSScanSelect.ImportBPK;
var opd : TOpenDialog;
    ts, tr : TStringList;
    crow : AnsiString;
    xls, xlw: Variant;
    fn : TFileName;
    i : integer;
begin
  opd := TOpenDialog.Create(self);
  opd.Title := 'Import BPKB Acceptance List';
  opd.InitialDir := GetCurrentDir;
  opd.Options := [ofFileMustExist];
  opd.Filter := 'Excel|*.xls';
  opd.DefaultExt := 'xls';
  lsbBPK.Clear;

  ts := TStringList.Create;
  tr := TStringList.Create;

  if (opd.Execute) and (opd.FileName <> '') then
    begin
      pnPlzWait.Visible := true;
      lbWait.Caption := 'Convert XLS to CSV';
      imgWait.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'wait.gif');
      gauData.Progress := 0;
      Application.ProcessMessages;
      fn := opd.FileName;
      xls := CreateOleObject('Excel.Application');
      xlw := xls.WorkBooks.Open(fn);
      fn := ChangeFileExt(opd.FileName,'.csv');
      xlw.SaveAs(fn, xlCSV);
      lbWait.Caption := 'Convert Done';
      Application.ProcessMessages;
      xlw.Close;
      xlw := UnAssigned;
      xls.Quit;
      xls := UnAssigned;

      lbWait.Caption := 'Crow Header';
      Application.ProcessMessages;
      ts.LoadFromFile(fn);
      if pos(',,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,', ts.Text) > 0
        then crow := 'No,,Lessee Name,,Transaction ID,Transaction ID NFS,,,,,Description,Chasis / Engine No,,,Police No,,,,,Owner Name,,No,Type,Wrk. Date,,,Bef Sts,,,Officer,Acc. Own. '
        else crow := 'No,,Lessee Name,,Transaction ID,Transaction ID NFS,,,,Description,,Chasis / Engine No,,,Police No,,,,,Owner Name,,No,Type,Wrk. Date,,,Bef Sts,,,Officer,Acc. Own. ';
      tr.Append(crow);
      lbWait.Caption := 'replacing body';
      Application.ProcessMessages;
      for i := 15 to ts.Count - 1 do
        begin
          crow := '';
          crow := StringReplace(ts.Strings[i], ',,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,', '', [rfReplaceAll, rfIgnoreCase]);
          crow := StringReplace(crow, ',,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,', '', [rfReplaceAll, rfIgnoreCase]);
          crow := StringReplace(crow, '   /', ',', [rfReplaceAll, rfIgnoreCase]);
          crow := StringReplace(crow, 'Transaction:,,,', 'Transaction : ', [rfReplaceAll, rfIgnoreCase]);
          tr.Append(crow);
        end;

      for i := tr.Count - 1 downto 0 do
        begin
          if Trim(tr.Strings[i]) = '' then tr.Delete(i);
          lbWait.Caption := 'Processing '+intToStr(tr.Count)+' lines';
          Application.ProcessMessages;
        end;

      tr.SaveToFile(fn);
      lbWait.Caption := 'Processing DECC';
      Application.ProcessMessages;
      ExeDOSAndWait(ExtractFilePath(Application.ExeName) + 'decc.exe ' + fn + ' tmp.csv', SW_HIDE);
      ExeDOSAndWait(ExtractFilePath(Application.ExeName) + 'decc.exe tmp.csv ' + fn, SW_HIDE);
      lbWait.Caption := 'Processing CSV';
      Application.ProcessMessages;
      proccessBPKCSV(opd.FileName, lsbBPK);
      lbWait.Caption := 'Done';
      Application.ProcessMessages;

    end;

  opd.Free;
  ts.Free;
  tr.Free;

  fileDat := ExtractFilePath(Application.ExeName) + SelectSplitString(crowList.Strings[pgc.ActivePage.Tag-1],1) + '.dat';
  SaveAsDB(lsbBPK,fileDat);
  pnPlzWait.Visible := false;
end;

procedure TfrmDMSScanSelect.proccessOLECSV(xlsName:TFileName; chbx : TListBox);
var tsr,rowData : TStringList;
    csvName : TFileName;
    i : integer;
begin
  tsr := TStringList.Create;
  rowData := TStringList.Create;
  csvName := ChangeFileExt(xlsName, '.csv');
  //ListBox1.Clear;
  if FileExists(csvName) then
    begin
      tsr.LoadFromFile(csvName);
      for i := 1 to tsr.Count - 1 do
        begin
          rowData.Text := AnsiReplaceStr(tsr.Strings[i],',',#13#10);
          chbx.Items.Add(rowData[0] + ' | ' + rowData[2] + ' | ' + rowData[1]);
          //ListBox1.Items.Add(IntToStr(i) + ' -> ' + tsr.Strings[i]);
        end;
    end;
end;

procedure TfrmDMSScanSelect.ImportOLE;
var opd : TOpenDialog;
    crow : AnsiString;
    fn : TFileName;
    i : integer;
begin
  opd := TOpenDialog.Create(self);
  opd.Title := 'Import OTO Lease CSV';
  opd.InitialDir := GetCurrentDir;
  opd.Options := [ofFileMustExist];
  opd.Filter := 'Comma Delimited|*.csv';
  opd.DefaultExt := 'csv';
  lsbOLE.Clear;

 if (opd.Execute) and (opd.FileName <> '') then
    begin
      pnPlzWait.Visible := true;
      lbWait.Caption := 'Processing CSV';
      imgWait.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'wait.gif');
      Application.ProcessMessages;
      proccessOLECSV(opd.FileName, lsbOLE);
      lbWait.Caption := 'Done';
      Application.ProcessMessages;
    end;

  fileDat := ExtractFilePath(Application.ExeName) + SelectSplitString(crowList.Strings[pgc.ActivePage.Tag-1],1) + '.dat';
  SaveAsDB(lsbOLE,fileDat);
  pnPlzWait.Visible := false;
end;

procedure TfrmDMSScanSelect.SaveAsDB(ls : TLIstBox; fts : TFileName);
begin
  if ls.Items.Count > 0 then
    begin
      if FileExists(fts) then deletefile(fts);
      ls.Items.SaveToFile(fts);
    end;
end;


procedure TfrmDMSScanSelect.FormShow(Sender: TObject);
var i : integer;
    tmpLsb : TListBox;
    tmpPn : TPanel;
begin
  pnPlzWait.Visible := false;

  svrLayOut := TStringList.Create;
  svrLayOut := getLayOut(StrToInt(getDBConfig(1)));
  docCount := StrToInt(svrLayOut.Strings[8]);

  crowList := TStringList.Create;
  crowList := docLayOut(svrLayOut);

  for i := 0 to crowList.Count-1 do
    begin
      pgc.Pages[i].TabVisible := true;
      if crowList.Strings[i] <> '-' then
        begin
          fileDat := ExtractFilePath(Application.ExeName) + SelectSplitString(crowList.Strings[i],1) + '.dat';
          if FileExists(fileDat) then
            begin
              tmpLsb := FindComponent('lsb'+SelectSplitString(crowList.Strings[i],1)) as TListBox;
              if tmpLsb <> nil then
                begin
                  tmpLsb.Clear;
                  tmpLsb.Items.LoadFromFile(fileDat);
                  tmpPn := FindComponent('pn'+SelectSplitString(crowList.Strings[i],1)) as TPanel;
                  tmpPn.Caption := DateTimeToStr(GetFileCreationTime(fileDat))
                end;
            end;
        end
      else pgc.Pages[i].TabVisible := false;
    end;

end;

procedure TfrmDMSScanSelect.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  pnPlzWait.Visible := false;
end;

procedure TfrmDMSScanSelect.btSelesaiClick(Sender: TObject);
begin
  close;
end;

procedure TfrmDMSScanSelect.btImportDataClick(Sender: TObject);
begin
  case pgc.ActivePage.Tag of
    1 : ImportCOP;
    2 : ImportBPK;
    3 : ImportOLE;
  end;
end;

procedure TfrmDMSScanSelect.lsbCOPDblClick(Sender: TObject);
var tmpTS : TStringList;
begin
  tmpTS := TStringList.Create;
  SplitString (tmpTS, (Sender as TListBox).Items.Strings[(Sender as TListBox).ItemIndex] + '|||');
  frmDMSScanSelectEdit.edE1.Text := trim(tmpTS.Strings[0]);
  frmDMSScanSelectEdit.edE2.Text := trim(tmpTS.Strings[1]);
  frmDMSScanSelectEdit.edE3.Text := trim(tmpTS.Strings[2]);
  frmDMSScanSelectEdit.Tag := (Sender as TListBox).ItemIndex;
  frmDMSScanSelectEdit.Caption := 'Entry Editor Record : ' + IntToStr((Sender as TListBox).ItemIndex+1);
  frmDMSScanSelectEdit.lbFile.Caption := SelectSplitString(crowList.Strings[pgc.ActivePage.tag-1],1) + '.dat';
  frmDMSScanSelectEdit.ShowModal;
  if MessageDlg('Reload Data', mtConfirmation, [mbYes], 0) = mrYes then
    (Sender as TListBox).Items.LoadFromFile(ExtractFilePath(Application.ExeName) + SelectSplitString(crowList.Strings[pgc.ActivePage.tag-1],1) + '.dat');
end;

end.
