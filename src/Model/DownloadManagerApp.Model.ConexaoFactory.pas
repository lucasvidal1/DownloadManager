unit DownloadManagerApp.Model.ConexaoFactory;

interface

uses DownloadManagerApp.Model.Interfaces;

Type
    TModelConexaoFactory = class(TInterfacedObject, iModelConexaoFactory)
    private
    public
        constructor Create;
        destructor Destroy; override;
        class function New : iModelConexaoFactory;
        function Conexao : iModelConexao;
        function Query : iModelQuery;
    end;

implementation

uses
  DownloadManagerApp.Model.FiredacConexao,
  DownloadManagerApp.Model.FiredacQuery;

{ TModelConexaoFactory }

function TModelConexaoFactory.Conexao: iModelConexao;
begin
    Result := TModelFiredacConexao.New;
end;

constructor TModelConexaoFactory.Create;
begin

end;

destructor TModelConexaoFactory.Destroy;
begin
    inherited;
end;

class function TModelConexaoFactory.New: iModelConexaoFactory;
begin
    Result := Self.Create;
end;

function TModelConexaoFactory.Query: iModelQuery;
begin
    Result := TModelFiredacQuery.New(Self.Conexao);
end;

end.
