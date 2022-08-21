unit DownloadManagerApp.Model.Interfaces;

interface

uses
  Data.DB;

type
  iModelQuery = interface;

  iModelConexao = interface
    ['{2B922514-BC41-462B-AADA-79474E638249}']
    function Connection: TObject;
  end;

  iModelConexaoFactory = interface
    ['{CC471ED9-A63E-4E45-9DF8-FC986D4BB47B}']
    function Conexao: iModelConexao;
    function Query: iModelQuery;
  end;

  iModelQuery = interface
    ['{8B451721-B420-4C82-B9A6-F7807575CDEB}']
    function Query: TObject;
    function Open(aSQL: String): iModelQuery;
    function ExecSQL(aSQL: String): iModelQuery;
    function ExecSQLReturning(aSQL: String): Integer;
  end;

  iModelEntidade = interface
    ['{D86CA886-810F-49F2-B7C0-B9E38C16FEBE}']
    function DataSet(aValue: TDataSource): iModelEntidade;
    procedure ExecSQL(aValue: String);
    function ExecSQLReturning(aValue: String): Integer;
    procedure Open;
  end;

  iModelEntidadeFactory = interface
    ['{7386C280-F5CD-477A-A4A5-A8A54603BC76}']
    function Historico: iModelEntidade;
  end;

implementation

end.
