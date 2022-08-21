unit DownloadManagerApp.View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls, Vcl.ComCtrls, IdComponent, DownloadManagerApp.Util.Download,
  DownloadManagerApp.Controller.Interfaces,
  DownloadManagerApp.Controller.Download, Vcl.Dialogs,
  Vcl.Forms, DownloadManagerApp.Controller.Thread,
  DownloadManagerApp.View.Historico;

type
  TfrmPrincipal = class(TForm)
    Image1: TImage;
    pnlMain: TPanel;
    lblLink: TLabel;
    edtUrl: TEdit;
    pnlTop: TPanel;
    btnIniciarDownload: TButton;
    progressDownload: TProgressBar;
    lblProgresso: TLabel;
    dlgSave: TSaveDialog;
    btnCancelarDownload: TButton;
    btnExibirMensagem: TButton;
    btnExibirHistorico: TButton;
    procedure btnIniciarDownloadClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelarDownloadClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnExibirMensagemClick(Sender: TObject);
    procedure btnExibirHistoricoClick(Sender: TObject);
  private
    { Private declarations }
    FDownload: iControllerDownload;
    FThreadDownload: TThreadDownload;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.btnExibirHistoricoClick(Sender: TObject);
var
  form: TfrmHistorico;
begin
  try
    form := TfrmHistorico.Create(Self);
    form.ShowModal;
  finally
    FreeAndNil(form);
  end;
end;

procedure TfrmPrincipal.btnExibirMensagemClick(Sender: TObject);
begin
  Application.MessageBox(PChar('Download em ' + FDownload.GetProgressoDownload +
    '%'), 'Download Manager App', MB_OK + MB_DEFBUTTON2);
end;

procedure TfrmPrincipal.btnIniciarDownloadClick(Sender: TObject);
begin
  dlgSave.Filter := 'Arquivos' + ExtractFileExt(edtUrl.Text) + '|*' +
    ExtractFileExt(edtUrl.Text);
  dlgSave.FileName := 'Arquivo';

  if dlgSave.Execute then
  begin
    if FDownload.GetDownloadEmAndamento then
      FDownload.CancelarDownload;

    FDownload.
    SetUrl(edtUrl.Text).
    SetCaminhoArquivo(dlgSave.FileName + ExtractFileExt(edtUrl.Text));

    if FThreadDownload <> nil then
    begin
      if not FThreadDownload.Finished then
        FThreadDownload.Terminate;
      FreeAndNil(FThreadDownload);
    end;

    FThreadDownload := TThreadDownload.Create(FDownload);
    FThreadDownload.Start;
  end;
end;

procedure TfrmPrincipal.btnCancelarDownloadClick(Sender: TObject);
begin
  if FThreadDownload <> nil then
    FThreadDownload.Desconectar;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FDownload.GetDownloadEmAndamento then
  begin
    if Application.MessageBox
      ('Existe um download em andamento, deseja interrompe-lo?',
      'Download Manager App', MB_YESNO + MB_DEFBUTTON2) = IDNO then
      Abort
    else
      FThreadDownload.Desconectar;
  end;

  if FThreadDownload <> nil then
  begin
    if not FThreadDownload.Finished then
      FThreadDownload.Terminate;
    FreeAndNil(FThreadDownload);
  end;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  FDownload := TDownload.New(progressDownload);
end;

end.
