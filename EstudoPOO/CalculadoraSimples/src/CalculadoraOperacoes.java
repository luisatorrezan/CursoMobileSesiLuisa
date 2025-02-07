import java.util.Scanner;

public class CalculadoraOperacoes {
    //atributos
    double numero1, numero2, resultado;
    String operacao;
    boolean coninuar = true;


    //construtores (vazio)


    //métodos
    //soma
    public double soma (double a, double b){
        return a+b;
    }
    //subtração
    public double sub (double a, double b){
        return a-b;
    }
    //multiplicação
    public double multi (double a, double b){
        return a*b;
    }
    //divisão
    public double div (double a, double b){
        return a/b;
    }
    //menu
    public void menu(){
        Scanner sc = new Scanner(System.in);
        do {
            System.out.println("====Calculadora Simples====");
            System.out.println("====Escolha a Operação:====");
            System.out.println("1. Soma");
            System.out.println("2. Subtração");
            System.out.println("3. Multiplicação");
            System.out.println("4. Divisão");
            System.out.println("5. sair");
            System.out.println("===========================");
            operacao = sc.next();
            //tomada de decisão - condição
            switch (operacao) {
                case "1":
                    System.out.println("Informe 1º nº");
                    numero1 = sc.nextDouble();
                    System.out.println("Informe 2º nº");
                    numero1 = sc.nextDouble();
                    resultado = soma(numero1, numero2);
                    System.out.println("o resultado é "+resultado);
                    break;
                case "2":
                    System.out.println("Informe 1º nº");
                    numero1 = sc.nextDouble();
                    System.out.println("Informe 2º nº");
                    numero1 = sc.nextDouble();
                    resultado = sub(numero1, numero2);
                    System.out.println("o resultado é "+resultado);
                    break;
                case "3":
                    System.out.println("Informe 1º nº");
                    numero1 = sc.nextDouble();
                    System.out.println("Informe 2º nº");
                    numero1 = sc.nextDouble();
                    resultado = multi(numero1, numero2);
                    System.out.println("o resultado é "+resultado);
                    break;
                case "4":
                    System.out.println("Informe 1º nº");
                    numero1 = sc.nextDouble();
                    System.out.println("Informe 2º nº");
                    numero1 = sc.nextDouble();
                    if (numero2 ==0){
                        System.out.println("NÃO DIVIDÌRAS POR 0!!!");
                    }else{
                        resultado = div(numero1, numero2);
                        System.out.println("o resultado é "+resultado);
                    }
                    break;
                case "5":
                    coninuar = false;
                    System.out.println("Saindo...");
                    break;
                default:
                    System.out.println("Escolha uma operação valida pelo amor de Deus!!!");
                    break;
            }
        } while (coninuar);
        sc.close();
    }

}
