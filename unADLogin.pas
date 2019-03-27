unit unADLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmADLogin = class(TForm)
    UserName: TLabel;
    edu: TEdit;
    Password: TLabel;
    edp: TEdit;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmADLogin: TfrmADLogin;

implementation

uses GenericFP;

{$R *.dfm}

procedure TfrmADLogin.FormShow(Sender: TObject);
begin
  edu.Text := GetLocalUserLogin(0);
  edp.Text := '';
end;

procedure TfrmADLogin.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
{}
end;

end.
