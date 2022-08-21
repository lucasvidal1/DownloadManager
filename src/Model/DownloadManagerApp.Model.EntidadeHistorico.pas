unit DownloadManagerApp.Model.EntidadeHistorico;

interface

uses DownloadManagerApp.Model.Interfaces, Data.DB;

Type
  TModelEntidadeHistorico = class(TInterfacedObject, iModelEntidade)
  private
    FQuery: iModelQuery;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iModelEntidade;
    function DataSet(aValue: TDataSource): iModelEntidade;
    procedure ExecSQL(aValue: String);
    function ExecSQLReturning(aValue: String): Integer;
    procedure Open;
  end;

implementation

uses
  DownloadManagerApp.Model.ConexaoFactory;

{ TModelEntidadeHistorico }

constructor TModelEntidadeHistorico.Create;
begin
  FQuery := TModelConexaoFactory.New.Query;
end;

function TModelEntidadeHistorico.DataSet(aValue: TDataSource): iModelEntidade;
begin
  Result := Self;
  aValue.DataSet := TDataSet(FQuery.Query);
end;

destructor TModelEntidadeHistorico.Destroy;
begin
  inherited;
end;

procedure TModelEntidadeHistorico.ExecSQL(aValue: String);
begin
  FQuery.ExecSQL(aValue);
end;

function TModelEntidadeHistorico.ExecSQLReturning(aValue: String): Integer;
begin
  Result := FQuery.ExecSQLReturning(aValue);
end;

class function TModelEntidadeHistorico.New: iModelEntidade;
begin
  Result := Self.Create;
end;

procedure TModelEntidadeHistorico.Open;
begin
  FQuery.Open('SELECT * FROM LOGDOWNLOAD');
end;

end.
