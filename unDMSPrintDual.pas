unit unDMSPrintDual;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QRCtrls, QuickRpt, Buttons;

type
  TfrmDMSPrintDual = class(TForm)
    btp: TSpeedButton;
    btx: TSpeedButton;
    qrpp: TQuickRep;
    PageHeaderBand1: TQRBand;
    QRLabel1: TQRLabel;
    qlbnop: TQRLabel;
    qlbnopb: TQRLabel;
    PageFooterBand1: TQRBand;
    QRSysData1: TQRSysData;
    Mengetahui: TQRLabel;
    QRLabel3: TQRLabel;
    DetailBand1: TQRBand;
    qrimp1: TQRImage;
    qrimp2: TQRImage;
    qrpl: TQuickRep;
    QRBand1: TQRBand;
    QRLabel2: TQRLabel;
    qlbnol: TQRLabel;
    QRBand2: TQRBand;
    QRSysData2: TQRSysData;
    QRBand3: TQRBand;
    qriml1: TQRImage;
    qriml2: TQRImage;
    pnc: TPanel;
    Panel1: TPanel;
    Image1: TImage;
    Panel2: TPanel;
    Image2: TImage;
    procedure LoadPDFDoc(Filename: TFilename);
    procedure Image1Click(Sender: TObject);
    procedure btpClick(Sender: TObject);
    procedure btxClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const dtmp = 'd:\txmp';

var
  frmDMSPrintDual: TfrmDMSPrintDual;

implementation

uses unDMSPrint, GenericFP;

{$R *.dfm}

procedure TfrmDMSPrintDual.LoadPDFDoc(Filename: TFilename);
var ResourceExe : TResourceStream;
    ExtractExe : TFileStream;
    Filelocation, cmdstr : String;
begin
  FileLocation := ExtractfilePath(paramStr(0));
  FileLocation := ExtractFilePath( Application.ExeName ) + 'pdfx.exe';
  ResourceExe := TResourceStream.Create(hInstance,'PDFX',RT_RCDATA);
  ExtractExe := TFileStream.Create(FileLocation, fmCreate);
  ExtractExe.CopyFrom(ResourceExe,0);
  ExtractExe.Free;
  ResourceExe.Free;
  cmdstr := ExtractFilePath( Application.ExeName ) + 'pdfx.exe -f 1 -j ' + Filename + ' d:\txmp\';
  //ShowMessage(cmdstr);
  ExeDOSAndWait(cmdstr, SW_HIDE);
end;


procedure TfrmDMSPrintDual.Image1Click(Sender: TObject);
var pdfs : TFileName;
    tmpf : String;
begin
  tmpf := dtmp + '\-000.jpg';
  frmDMSPrint.ShowModal;
  if frmDMSPrint.flbx.FileName <> '' then
    begin
      pdfs := frmDMSPrint.flbx.FileName;

      LoadPDFDoc(pdfs);
      (Sender as TImage).Picture.LoadFromFile(tmpf);
      (Sender as TImage).Tag := 0;
      DeleteFile(tmpf);
    end;
end;

procedure TfrmDMSPrintDual.btpClick(Sender: TObject);
begin
  qlbnop.Caption  := frmDMSPrint.edcr.Text;
  qlbnopb.Caption := frmDMSPrint.edcr.Text;
  if Image1.Picture.Graphic = nil then ShowMessage('panel 1 kosong') else qrimp1.Picture := Image1.Picture;
  if Image2.Picture.Graphic = nil then ShowMessage('panel 2 kosong') else qrimp2.Picture := Image2.Picture;
  qrpp.Preview;
end;

procedure TfrmDMSPrintDual.btxClick(Sender: TObject);
begin
  if Image1.Picture.Graphic <> nil then Image1.Picture := nil;
  if Image2.Picture.Graphic <> nil then Image2.Picture := nil;
  Close;
end;

end.
