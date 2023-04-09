program Samples;

uses
  Vcl.Forms,
  UfrmSamples in 'UfrmSamples.pas' {frmSamples},
  AWS4Delphi.Interfaces in '..\src\AWS4Delphi.Interfaces.pas',
  AWS4Delphi.SMS in '..\src\AWS4Delphi.SMS.pas',
  AWS4Delphi.S3 in '..\src\AWS4Delphi.S3.pas',
  AWS4Delphi.Constants in '..\src\AWS4Delphi.Constants.pas',
  AWS4Delphi.Email in '..\src\AWS4Delphi.Email.pas',
  AWS4Delphi.Model.SMS in '..\src\AWS4Delphi.Model.SMS.pas',
  AWS4Delphi.Model.S3 in '..\src\AWS4Delphi.Model.S3.pas',
  AWS4Delphi.Model.Email in '..\src\AWS4Delphi.Model.Email.pas',
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Glow');
  Application.CreateForm(TfrmSamples, frmSamples);
  Application.Run;
end.
