unit unDocManSConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, DBCtrls, Buttons, ComCtrls;

type
  T_Config = class(TForm)
    pgc: TPageControl;
    tbsLocConfig: TTabSheet;
    tbsDocConfig: TTabSheet;
    pnc: TPanel;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    btExit: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btExitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  _Config: T_Config;

implementation

uses unDocManSData;

{$R *.dfm}

procedure T_Config.FormShow(Sender: TObject);
begin
  dm.cdsDBCfg.Open;
  dm.cdsDBGrp.Open;
end;

procedure T_Config.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  dm.cdsDBCfg.Close;
  dm.cdsDBGrp.Close;
  close;
end;

procedure T_Config.btExitClick(Sender: TObject);
begin
  close;
end;

end.
