program prjDocManS;



uses
  Forms,
  unDocManSMain in 'unDocManSMain.pas' {_Main},
  unDocManSData in 'unDocManSData.pas' {dm: TDataModule},
  unADLogin in 'unADLogin.pas' {frmADLogin},
  GenericFP in '..\..\..\_Shared\GenericFP.pas',
  unDMSScanADF in 'unDMSScanADF.pas' {frmDMSScanADF},
  unDMSScanFB in 'unDMSScanFB.pas' {frmDMSScanFB},
  unDMSScanView in 'unDMSScanView.pas' {frmDMSScanView},
  unDMSScanVerify in 'unDMSScanVerify.pas' {frmDMSScanVerify},
  unDMSPrint in 'unDMSPrint.pas' {frmDMSPrint},
  unDMSEmail in 'unDMSEmail.pas' {frmDMSEmail},
  unDocManSConfig in 'unDocManSConfig.pas' {_Config},
  unDocManSSecurity in 'unDocManSSecurity.pas' {_Security},
  unDocManSUserEditor in 'unDocManSUserEditor.pas' {_UserEditor},
  unDMSScanSelect in 'unDMSScanSelect.pas' {frmDMSScanSelect},
  FolderMon in '..\..\..\_Shared\FolderMon.pas',
  unDMSPrintQuatro in 'unDMSPrintQuatro.pas' {frmDMSPrintQuatro},
  unDMSPrintDual in 'unDMSPrintDual.pas' {frmDMSPrintDual},
  unDMSScanFBProccess in 'unDMSScanFBProccess.pas' {frmDMSScanFBProccess},
  CheckPrevious in 'CheckPrevious.pas',
  unDMSScanSelectEdit in 'unDMSScanSelectEdit.pas' {frmDMSScanSelectEdit};

{$R *.res}
{$R ddm.res} 
{$TYPEDADDRESS OFF} //muss so sein (this have to be)

begin
  if not CheckPrevious.RestoreIfRunning(Application.Handle) then
    begin
      Application.Initialize;
      Application.Title := 'Document Management System';
      Application.CreateForm(T_Main, _Main);
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrmADLogin, frmADLogin);
  Application.CreateForm(TfrmDMSScanADF, frmDMSScanADF);
  Application.CreateForm(TfrmDMSScanFB, frmDMSScanFB);
  Application.CreateForm(TfrmDMSScanView, frmDMSScanView);
  Application.CreateForm(TfrmDMSScanVerify, frmDMSScanVerify);
  Application.CreateForm(TfrmDMSPrint, frmDMSPrint);
  Application.CreateForm(TfrmDMSEmail, frmDMSEmail);
  Application.CreateForm(T_Config, _Config);
  Application.CreateForm(T_Security, _Security);
  Application.CreateForm(T_UserEditor, _UserEditor);
  Application.CreateForm(TfrmDMSScanSelect, frmDMSScanSelect);
  Application.CreateForm(TfrmDMSPrintQuatro, frmDMSPrintQuatro);
  Application.CreateForm(TfrmDMSPrintDual, frmDMSPrintDual);
  Application.CreateForm(TfrmDMSScanFBProccess, frmDMSScanFBProccess);
  Application.CreateForm(TfrmDMSScanSelectEdit, frmDMSScanSelectEdit);
  Application.Run;
      end;
end.
