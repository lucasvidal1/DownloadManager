unit DownloadManagerApp.View.Historico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Comp.Client, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.DApt, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Grids,
  Vcl.DBGrids, DownloadManagerApp.Controller.Interfaces,
  DownloadManagerApp.Controller.Entidades;

type
  TfrmHistorico = class(TForm)
    DataSource: TDataSource;
    pnlMain: TPanel;
    Panel1: TPanel;
    Label1: TLabel;
    DBGrid: TDBGrid;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

    FController: iControllerEntidades;
  public
    { Public declarations }
  end;

var
  frmHistorico: TfrmHistorico;

implementation

{$R *.dfm}

procedure TfrmHistorico.FormCreate(Sender: TObject);
begin
  FController := TControllerEntidades.New;

  FController.Entidades.Historico.DataSet(DataSource).Open;
end;

end.
