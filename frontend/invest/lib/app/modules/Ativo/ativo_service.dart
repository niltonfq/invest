import 'package:commons_deps/commons_deps.dart';
import 'package:micro_core/app/log/log_logger.dart';
import 'package:micro_core/micro_core.dart';

import '../tipo_ativo/models/tipo_ativo_view_model.dart';
import 'ativo_repository.dart';
import 'models/ativo_view_model.dart';

class AtivoService extends BaseApiService {
  final LogLogger _log = LogLogger();

  AtivoService({required AtivoRepository repository}) {
    repoApi = repository;
    recurso = '/ativos/';
  }

// /ativos/posicaoTipoAtivo/usuario/{usuarioId}

  AsyncResult<List<TipoAtivoViewModel>, Exception>
      findPosicaoPorTipoAtivo() async {
    try {
      var response = await repoApi.get(
        uri: 'http://localhost:8088' +
            recurso +
            '/posicaoTipoAtivo/usuario/7062c0e4-6e5d-4125-ad1c-7363cf72e45c',
      );
      if (response.statusCode == 200) {
        List<TipoAtivoViewModel> tipoAtivoList = [];
        List lista = (response.body as List);
        for (var i = 0; i < lista.length; i++) {
          TipoAtivoViewModel tipoAtivoViewModel = TipoAtivoViewModel();
          tipoAtivoViewModel.quantidade = lista[i]['quantidade'];
          tipoAtivoViewModel.percentual = lista[i]['percentual'];
          tipoAtivoViewModel.total = lista[i]['total'];
          tipoAtivoViewModel.tipoAtivo = lista[i]['tipoAtipo'];
          tipoAtivoViewModel.ativos = [];

          List items = lista[i]['ativos'];
          for (var j = 0; j < items.length; j++) {
            AtivoViewModel ativoViewModel = AtivoViewModel();
            ativoViewModel.codigo = items[j]['codigo'];
            ativoViewModel.diferenca = items[j]['diferenca'];
            ativoViewModel.patrimonio = items[j]['patrimonio'];
            ativoViewModel.percentual = items[j]['percentual'];
            ativoViewModel.percentualCarteira = items[j]['percentualCarteira'];
            ativoViewModel.precoAtual = items[j]['precoAtual'];
            ativoViewModel.precoMedio = items[j]['precoMedio'];
            ativoViewModel.quantidade = items[j]['quantidade'];
            ativoViewModel.totalInvestido = items[j]['totalInvestido'];
            tipoAtivoViewModel.ativos?.add(ativoViewModel);
          }
          tipoAtivoList.add(tipoAtivoViewModel);
        }
        return Success(tipoAtivoList);
      } else {
        return Failure(
          Exception('Erro ao consultar ativos posição por tipo '),
        );
      }
    } catch (e) {
      _log.e(e.toString());
      return Failure(
        Exception('Erro ao consultar ativos posição por tipo '),
      );
    }
  }

  AsyncResult<Response<dynamic>, Exception> findAll([
      int page = 0, String order = '']) async {
    try {
      var response = await repoApi.get(
        uri: EnvironmentConfig.SERVER +
            recurso +
            '/usuario/' +
            EnvironmentConfig.USER +
            '?page=$page&sort=$order',
      );
      if (response.statusCode == 200) {
        return Success(response);
      } else {
        return Failure(
          Exception('Erro ao consultar ativos'),
        );
      }
    } catch (e) {
      _log.e(e.toString());
      return Failure(
        Exception('Erro ao consultar ativos'),
      );
    }
  }
}
