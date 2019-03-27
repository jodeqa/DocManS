unit unDocManSSecurity;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, Buttons, ExtCtrls, StdCtrls;

type
  T_Security = class(TForm)
    dbgCU: TDBGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    btUserConfig: TSpeedButton;
    btExit: TSpeedButton;
    Label1: TLabel;
    lbCU: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btExitClick(Sender: TObject);
    procedure btUserConfigClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  _Security: T_Security;

implementation

uses unDocManSData, unDocManSUserEditor;

{$R *.dfm}

procedure T_Security.FormShow(Sender: TObject);
var cu : String;
begin
  cu := trim(dm.adOTO.CurrentUserName);
  lbCU.Caption := cu;

  dm.adqCU.Close;
  dm.adqCU.Parameters.ParamByName('currUsr').Value := cu;
  dm.adqCU.Open
end;

procedure T_Security.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  dm.adqCU.Close;
  Close;
end;

procedure T_Security.btExitClick(Sender: TObject);
begin
  close;
end;

procedure T_Security.btUserConfigClick(Sender: TObject);
begin
  _UserEditor.ShowModal;
end;

end.
