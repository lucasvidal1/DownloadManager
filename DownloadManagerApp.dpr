program DownloadManagerApp;

uses
  Vcl.Forms,
  DownloadManagerApp.View.Principal in 'src\View\DownloadManagerApp.View.Principal.pas' {frmPrincipal},
  DownloadManagerApp.Util.Download in 'src\Util\DownloadManagerApp.Util.Download.pas',
  DownloadManagerApp.Controller.Interfaces in 'src\Controller\DownloadManagerApp.Controller.Interfaces.pas',
  DownloadManagerApp.Controller.Download in 'src\Controller\DownloadManagerApp.Controller.Download.pas',
  DownloadManagerApp.Controller.Thread in 'src\Controller\DownloadManagerApp.Controller.Thread.pas',
  DownloadManagerApp.Model.Interfaces in 'src\Model\DownloadManagerApp.Model.Interfaces.pas',
  DownloadManagerApp.View.Historico in 'src\View\DownloadManagerApp.View.Historico.pas' {frmHistorico},
  DownloadManagerApp.Model.FiredacConexao in 'src\Model\DownloadManagerApp.Model.FiredacConexao.pas',
  DownloadManagerApp.Model.FiredacQuery in 'src\Model\DownloadManagerApp.Model.FiredacQuery.pas',
  DownloadManagerApp.Model.ConexaoFactory in 'src\Model\DownloadManagerApp.Model.ConexaoFactory.pas',
  DownloadManagerApp.Model.EntidadeHistorico in 'src\Model\DownloadManagerApp.Model.EntidadeHistorico.pas',
  DownloadManagerApp.Model.EntidadesFactory in 'src\Model\DownloadManagerApp.Model.EntidadesFactory.pas',
  DownloadManagerApp.Controller.Entidades in 'src\Controller\DownloadManagerApp.Controller.Entidades.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
