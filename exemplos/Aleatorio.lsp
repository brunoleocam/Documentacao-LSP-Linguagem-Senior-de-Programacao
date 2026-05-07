@ Exercício - Gerar número pseudoaleatório em intervalo @
Definir Funcao aleatorio(Numero pnInicial, Numero pnFinal, Numero pnDecimal, Numero End pnAleatorio);

Funcao aleatorio(Numero pnInicial, Numero pnFinal, Numero pnDecimal, Numero End pnAleatorio); {
  Definir Numero vnDataHora;
  Definir Numero vnParteFracionaria;
  Definir Numero vnSemente;
  Definir Numero vnMultiplicador;
  Definir Numero vnContador;
  Definir Numero vnInicialEscala;
  Definir Numero vnFinalEscala;
  Definir Numero vnFaixa;
  Definir Numero vnResto;
  Definir Numero vnValorAuxiliar;
  Definir Numero vnCasasDecimais;
  Definir Numero vnSorteadoEscala;

  @ Decimal negativo vira 0 @
  Se (pnDecimal < 0) {
    pnDecimal = 0;
  }
  vnCasasDecimais = pnDecimal;

  @ Se intervalo vier invertido, troca os limites @
  Se (pnFinal < pnInicial) {
    vnValorAuxiliar = pnInicial;
    pnInicial = pnFinal;
    pnFinal = vnValorAuxiliar;
  }

  @ Calcula 10^pnDecimal para escalar o intervalo @
  vnMultiplicador = 1;
  vnContador = 0;
  Enquanto (vnContador < pnDecimal) {
    vnMultiplicador = vnMultiplicador * 10;
    vnContador = vnContador + 1;
  }

  vnInicialEscala = Truncar(pnInicial * vnMultiplicador);
  vnFinalEscala = Truncar(pnFinal * vnMultiplicador);
  vnFaixa = (vnFinalEscala - vnInicialEscala) + 1;

  @ Intervalo com um único valor @
  Se (vnFaixa <= 1) {
    pnAleatorio = pnInicial;
  } Senao {
    @ Semente baseada na fração da data/hora atual @
    DataHora(vnDataHora);
    vnParteFracionaria = vnDataHora - Truncar(vnDataHora);
    vnSemente = Truncar(vnParteFracionaria * 1000000);

    RestoDivisao(vnSemente, vnFaixa, vnResto);
    vnSorteadoEscala = vnInicialEscala + vnResto;
    @ Com 0 casas, o sorteio ja e inteiro na escala: nao dividir nem Arredonda @
    @ (evita 2 virar 1 por precisao / regra do Arredonda com decimais = 0) @
    Se (pnDecimal = 0) {
      pnAleatorio = vnSorteadoEscala;
    } Senao {
      pnAleatorio = vnSorteadoEscala / vnMultiplicador;
      @ ArredondarValor(Valor, Qtde_Casas): precisao em variavel local @
      ArredondarValor(pnAleatorio, vnCasasDecimais);
    }
  }
}
