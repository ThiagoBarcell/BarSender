program ProjBarSenderMobile;

uses
  System.StartUpCopy,
  FMX.Forms,
  frmLoginBarSender in 'frmLoginBarSender.pas' {LoginBarSenderFrm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TLoginBarSenderFrm, LoginBarSenderFrm);
  Application.Run;
end.
