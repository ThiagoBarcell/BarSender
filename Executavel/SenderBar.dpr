program SenderBar;

uses
  Vcl.Forms,
  BarSender in 'BarSender.pas' {frmBarSender},
  BarSenderDM in 'Forms\BarSenderDM.pas' {frmBarSenderDM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmBarSender, frmBarSender);
  Application.CreateForm(TfrmBarSenderDM, frmBarSenderDM);
  Application.Run;
end.
