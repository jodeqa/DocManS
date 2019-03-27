unit unDocManSUserEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, Grids, DBGrids, ExtCtrls, Buttons, db,
  DBCtrls;

type
  T_UserEditor = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    dbgUserLIst: TDBGrid;
    Panel5: TPanel;
    clbxMenuAccess: TCheckListBox;
    Panel9: TPanel;
    dbgUserLIstWithAccess: TDBGrid;
    Panel7: TPanel;
    Panel8: TPanel;
    btAddUser: TSpeedButton;
    Label2: TLabel;
    edU: TEdit;
    Panel6: TPanel;
    Label3: TLabel;
    edCA: TEdit;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    DBText1: TDBText;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edCAChange(Sender: TObject);
    procedure edCAKeyPress(Sender: TObject; var Key: Char);
    procedure btAddUserClick(Sender: TObject);
    procedure clbxMenuAccessKeyPress(Sender: TObject; var Key: Char);
    procedure edUChange(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  _UserEditor: T_UserEditor;

implementation

uses unDocManSData;

{$R *.dfm}

procedure T_UserEditor.FormShow(Sender: TObject);
var bc : String;
begin
  bc := getDBConfig(3);

  dm.adqEmp.Close;
  dm.adqEmp.Parameters.ParamByName('bc').Value := bc;
  dm.adqEmp.Open;

  clbxMenuAccess.Clear;
  dm.adqMenu.Open;
    dm.adqMenu.First;
    dm.adqMenu.Next;
    dm.adqMenu.Next;
    while not dm.adqMenu.Eof do
      begin
        clbxMenuAccess.Items.Add(dm.adqMenu.FieldByName('ModulSubID').AsString + '.' + dm.adqMenu.FieldByName('ModulSubName').AsString);
        dm.adqMenu.Next;
      end;
  dm.adqMenu.Close;

  dm.adqCA.Close;
  dm.adqCA.Open;
end;

procedure T_UserEditor.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  dm.adqCA.Close;
  dm.adqEmp.Close;
  close;
end;

procedure T_UserEditor.edCAChange(Sender: TObject);
begin
  dm.adqEmp.Locate('employeeName', edCA.Text, [loCaseInsensitive, loPartialKey]);
  dm.adqCA.Locate('NTUserName', edU.Text, [loCaseInsensitive, loPartialKey]);
end;

procedure T_UserEditor.edCAKeyPress(Sender: TObject; var Key: Char);
begin
  if key = chr(VK_RETURN) then
    begin
      key := #0;
      clbxMenuAccess.SetFocus;
    end;
  if Key in ['a'..'z', 'A'..'Z']  then
    begin

    end
  else key := #0;
end;

procedure T_UserEditor.btAddUserClick(Sender: TObject);
var usrRightsList : TStringList;
    i : Integer;
    usrName, moID, moSubID, crtBy : String;
begin
  usrRightsList := TStringList.Create;
  for i := 0 to clbxMenuAccess.Items.Count - 1 do
    begin
      if clbxMenuAccess.Checked[i] then
      begin
        usrRightsList.Add(clbxMenuAccess.Items.Strings[i]);
      end;
    end;
  if usrRightsList.Count > 0 then
    begin
      if messagedlg( 'Tambah pengguna ' + dm.adqEmp.FieldByName('employeeName').AsString + #13 +
                     'dengan Akses ' + #13 + usrRightsList.Text
                     ,mtWarning
                     ,[mbYes,mbCancel], 0) = mrYes then
        begin
          usrName := dm.adqEmp.fieldByName('NTUserName').AsString;
          moID := getDBConfig(7);
          crtBy := trim(dm.adOTO.CurrentUserName);
          for i := 0 to usrRightsList.Count - 1 do
            begin
              moSubID := copy(usrRightsList.Strings[i],0,2);
              dm.adcCom.CommandText := 'merge into tu_userModul as tum ' +
                                       ' using (SELECT ' + QuotedStr(usrName) + ' as NTUserName , '+ moID +' as ModulID , '+ moSubID +' as ModulSubID ) as s ' +
                                       ' on s.NTUserName = tum.NTUserName and ' +
                                       '	s.ModulID = tum.ModulID and ' +
                                       '	s.ModulSubID = tum.ModulSubID ' +
                                       ' when not matched then ' +
                                       ' insert (NTUserName,MOdulID,MOdulSubId,RoleID,CreateBy) ' +
                                       ' values (' + QuotedStr(usrName) + ','+ moID +','+ moSubID +',1,' + QuotedStr(crtBy) + ');';
              dm.adcCom.Execute;
            end;
          dm.adqCA.Close;
          dm.adqCA.Open;
        end;
    end
  else MessageDlg('Tolong pilih dulu hak Akses untuk ' + dm.adqEmp.FieldByName('employeeName').AsString, mtError, [mbYes], 0);
end;

procedure T_UserEditor.clbxMenuAccessKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = chr(VK_RETURN) then
    begin
      key := #0;
      btAddUserClick(self);
    end;
end;

procedure T_UserEditor.edUChange(Sender: TObject);
begin
  dm.adqCA.Locate('NTUserName', edU.Text, [loCaseInsensitive, loPartialKey]);
end;

procedure T_UserEditor.SpeedButton2Click(Sender: TObject);
begin
  close;
end;

procedure T_UserEditor.SpeedButton1Click(Sender: TObject);
var NTName, moID, moSubID, moSubName : String;
begin
  NTName := dm.adqCA.FieldByName('NTUserName').AsString;
  moID := getDBConfig(7);
  moSubID := dm.adqCA.FieldByName('ModulSubID').AsString;
  moSubName := dm.adqCA.FieldByName('ModulSubName').AsString;

  if messagedlg( 'Hapus Pengguna ' + NTName + #13 +
                 'dengan akses ' + moSubName + ' ?'
                 ,mtWarning
                 ,[mbYes,mbCancel], 0) = mrYes then
    begin
      dm.adcCom.CommandText := 'delete from tu_userModul where NTUserName = ' + QuotedStr(NTName) + ' and ModulID = ' + moID + ' and ModulSubID = ' + moSubID;
      dm.adcCom.Execute;
      dm.adqCA.Close;
      dm.adqCA.Open;
    end;
end;

end.
