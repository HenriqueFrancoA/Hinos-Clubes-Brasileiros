import 'package:get/get.dart';
import 'package:hinos_clubes_brasileiros/models/time.dart';

class TimesController extends GetxController {
  RxList<Time> serieSelecionada = RxList();
  RxList<Time> timeSelecionado = RxList();

  List<String> timesSerieA = [
    "Athletico",
    "A. Goianiense",
    "A. Mineiro",
    "Bahia",
    "Botafogo",
    "Corinthians",
    "Criciúma",
    "Cruzeiro",
    "Cuiabá",
    "Flamengo",
    "Fluminense",
    "Fortaleza",
    "Grêmio",
    "Internacional",
    "Juventude",
    "Palmeiras",
    "RB Bragantino",
    "São Paulo",
    "Vasco da Gama",
    "Vitória",
  ];

  List<String> timesSerieB = [
    "Amazonas",
    "América Mineiro",
    "Avaí",
    "Botafogo SP",
    "Brusque",
    "Ceará",
    "Chapecoense",
    "Coritiba",
    "CRB",
    "Goiás",
    "Guarani",
    "Ituano",
    "Mirassol",
    "Novorizontino",
    "Operário",
    "Paysandu",
    "Pontepreta",
    "Santos",
    "Sport",
    "Vila Nova",
  ];

  List<String> timesSerieC = [
    "ABC",
    "Aparecidense",
    "Athletic",
    "Botafogo PB",
    "Caxias",
    "Confiança SE",
    "CSA",
    "Ferroviária",
    "Ferroviário CE",
    "Figueirense",
    "Floresta",
    "Londrina",
    "Naútico",
    "Remo",
    "Sampaio",
    "São Bernado",
    "São José RS",
    "Tombense",
    "Volta Redonda",
    "Ypiranga",
  ];

  List<String> timesSerieD = [
    "Água Santa",
    "Águia de Marabá",
    "Altos PI",
    "América RN",
    "Anápolis",
    "Asa de Arapiraca",
    "A. Cearense",
    "Audax",
    "Avenida",
    "Barra",
    "Brasil de Pelotas",
    "Brasiliense",
    "Cametá",
    "Capital",
    "Cascavel",
    "Cianorte",
    "Concórdia",
    "Costa Rica",
    "CRAC",
    "CSE",
    "Democrata",
    "Fluminense PI",
    "Hercílio Luz",
    "Humaitá",
    "Iguatu",
    "Inter de Limeira",
    "Ipatinga",
    "Iporá",
    "Itabaiana",
    "Itabuna",
    "Jacuipense",
    "Juazeirense",
    "Manauara",
    "Manaus",
    "Maracanã",
    "Maranhão",
    "Maringá",
    "Mixto",
    "Moto Club",
    "Nova Hamburgo",
    "Nova Iguaçu",
    "Petrolina",
    "Porto Velho",
    "Portuguesa RJ",
    "Potiguar",
    "Pouso Alegre",
    "Princesa",
    "Real Brasília",
    "Real Noroeste",
    "Retrô",
    "Rio Branco",
    "River",
    "Santa Cruz",
    "Santo André",
    "São José",
    "São Raimundo",
    "Sergipe",
    "Serra",
    "Sousa",
    "Tocantinópolis",
    "Trem",
    "Treze PB",
    "Rodonópolis",
    "Villa Nova MG",
  ];

  carregarTimes(int index) {
    serieSelecionada.clear();
    RxList<Time> listTimes = RxList();
    int x = 0;
    if (index == 0) {
      while (x < 20) {
        Time time = Time(
          nome: timesSerieA[x],
          pathEscudo: "assets/images/serie-a/${x + 1}.png",
          pathHino: "assets/sounds/serie-a/${x + 1}.mp3",
        );
        listTimes.add(time);
        x++;
      }
    } else if (index == 1) {
      while (x < 20) {
        Time time = Time(
          nome: timesSerieB[x],
          pathEscudo: "assets/images/serie-b/${x + 1}.png",
          pathHino: "assets/sounds/serie-b/${x + 1}.mp3",
        );
        listTimes.add(time);
        x++;
      }
    } else if (index == 2) {
      while (x < 20) {
        Time time = Time(
          nome: timesSerieC[x],
          pathEscudo: "assets/images/serie-c/${x + 1}.png",
          pathHino: "assets/sounds/serie-c/${x + 1}.mp3",
        );
        listTimes.add(time);
        x++;
      }
    } else if (index == 3) {
      while (x < 64) {
        Time time = Time(
          nome: timesSerieD[x],
          pathEscudo: "assets/images/serie-d/${x + 1}.png",
          pathHino: "assets/sounds/serie-d/${x + 1}.mp3",
        );
        listTimes.add(time);
        x++;
      }
    }

    serieSelecionada.addAll(listTimes);
  }

  selecionarTime(Time time) {
    timeSelecionado.clear();
    timeSelecionado.add(time);
  }
}
