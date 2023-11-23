unit frmLoginBarSender;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Actions,
  FMX.ActnList, FMX.Layouts, FMX.ExtCtrls, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.Objects, FMX.Edit, FMX.TabControl;

type
  TLoginBarSenderFrm = class(TForm)
    Layout2: TLayout;
    imgLogin: TImage;
    Layout1: TLayout;
    RoundRect1: TRoundRect;
    Layout3: TLayout;
    RoundRect2: TRoundRect;
    edtUsuario: TEdit;
    StyleBook1: TStyleBook;
    edtSenha: TEdit;
    Layout4: TLayout;
    RoundRect3: TRoundRect;
    Label1: TLabel;
    TabControl1: TTabControl;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LoginBarSenderFrm: TLoginBarSenderFrm;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}

end.
