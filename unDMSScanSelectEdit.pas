unit unDMSScanSelectEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TfrmDMSScanSelectEdit = class(TForm)
    Label1: TLabel;
    edE1: TEdit;
    Label2: TLabel;
    edE2: TEdit;
    Label3: TLabel;
    edE3: TEdit;
    Label4: TLabel;
    edE4: TEdit;
    btSelesai: TSpeedButton;
    lbFile: TLabel;
    procedure btSelesaiClick(Sender: TObject);
    procedure edE1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDMSScanSelectEdit: TfrmDMSScanSelectEdit;

implementation

{$R *.dfm}

procedure TfrmDMSScanSelectEdit.btSelesaiClick(Sender: TObject);
var tmpTS : TStringList;
begin
  if MessageDlg('Simpan Data ?', mtWarning, [mbYes, mbNo], 0) = mrYes then
    begin
      tmpTS := TStringList.Create;
      tmpTS.LoadFromFile(ExtractFilePath(Application.ExeName) + lbFile.Caption);
      tmpTS.Strings[frmDMSScanSelectEdit.Tag] := edE1.Text + ' | ' + edE2.Text + ' | ' + edE3.Text + ' | ' + edE4.Text;
      tmpTS.SaveToFile(ExtractFilePath(Application.ExeName) + lbFile.Caption);
    end;

  Close;
end;

procedure TfrmDMSScanSelectEdit.edE1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = chr(VK_RETURN) then
    begin
      key := #0;
      Perform(WM_NEXTDLGCTL,0,0);
    end;
end;

end.
