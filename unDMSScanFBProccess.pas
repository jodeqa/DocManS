unit unDMSScanFBProccess;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PdfDoc, PReport, PRJpegImage, ExtCtrls, Gauges;

type
  TfrmDMSScanFBProccess = class(TForm)
    gg: TGauge;
    PRPage1: TPRPage;
    PRLayoutPanel1: TPRLayoutPanel;
    PRJpegImage1: TPRJpegImage;
    PRPage2: TPRPage;
    PRLayoutPanel2: TPRLayoutPanel;
    PRJpegImage2: TPRJpegImage;
    PReport1: TPReport;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDMSScanFBProccess: TfrmDMSScanFBProccess;

implementation

{$R *.dfm}

end.
