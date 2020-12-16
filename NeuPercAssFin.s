.text
.globl main

main:
              li.s    $f1,0.004          #adiciona valor aleatorio no peso0
              li.s    $f2,0.67           #adiciona valor aleatorio no peso1
              li.s    $f3,0.05           #carrega taxa de aprendizado (TxAprendizado=0.05)
              li      $t0,18             #adiciona o numero de epocas que o neuronio sera treinado por todas as epocas necessarias

WHILEPOC:     
              beq     $t0,$zero,FI       #se o n° de epocas acabar(for igual a 0) o neuronio esta treinado / while(epoca!=0)
              addi    $t0,$t0,-1         #decrementa o numero de epocas / epoca--
              li      $t1,5              #adiciona o numero de iteracoes (ate que numero vai somar, ex. 5 iteracoes = 1+1;2+2;3+3;4+4;5+5) / iteracao = 5
              li.s    $f9,1.0            #adicona o primeiro numero a ser usado (1 - f9 terá 1.0)  / num = 1
WHILEIT:     
              beq     $t1,$zero,FIMITERA #se o n° de iteracoes acabar (for igual a 0) todos os numeros de treinamento ja foram somados / while(iteracao!=0)
              mul.s   $f4,$f1,$f9        #multiplica o peso0 pelo numero / (p0*num)
              mul.s   $f5,$f2,$f9        #multiplica o peso1 pelo numero / (p1*num)
              add.s   $f6,$f4,$f5        #soma os resultados / (soma = p0*num + p1*num)
              add.s   $f10,$f9,$f9       #soma o numero com ele mesmo / (num+num)
              sub.s   $f7,$f10,$f6       #subtrai dos numeros iguais somados o valor da operacao com os pesos e assim acha o erro / erro = (num+num) - soma
              mul.s   $f8,$f9,$f7        #multiplica o erro com o numero / (erro*num)
              mul.s   $f8,$f8,$f3        #multiplica o resultado anterior com a taxa de aprendizado (taxAprend = 0.05) / (erro*num)*TxAprendizado
              add.s   $f1,$f1,$f8        #muda o valor do peso 0 a partir da regra Wx = Wx + (Ero*Numero*TxAprendizado) / p0 + (erro*num)*TxAprendizado
              add.s   $f2,$f2,$f8        #muda o valor do peso 1 a partir da regra Wx = Wx + (Ero*Numero*TxAprendizado) / p1 + (erro*num)*TxAprendizado
              addi    $t1,$t1,-1         #descrementa numero de iteracoes / iteracao--
              addi.s  $f9,$f9,1.0        #incrementa o numero a ser usado / num++
              j       WHILEIT            #pula para o while da iteracao para saber se tem mais algum numero a ser somado
FIMITERA:    
              j       WHILEPOC           #pula para o while das epocas para saber se precisa treinar o neuronio por mais epocas


FI:
              li.s    $f11,0.0            #coloca 0.0 no $f13 só para ajudar nas operações adiante
              li.s    $f9,1.0             #volta o número para 1 / num = 1 
              li.s    $f6,0.0             #zera o soma / soma = 0
              li.s    $f12,80.0           #coloca 80.0 no $f12 só para ajudar nos próximos comandos

VERIF:
              sgt.s   $f13,$f9,$f12       #seta (1) $f13 se $f9(num) for maior que 80
              beqi.s  $f13,1,FINAl        #se $f13 for igual a 1 entao o número é maior que 80 e pula param o fim / while(num<=80)
              mul.s   $f4,$f1,$f9        #multiplica o peso0 pelo numero / (p0*num)
              mul.s   $f5,$f2,$f9        #multiplica o peso1 pelo numero / (p1*num)
              add.s   $f6,$f4,$f5        #soma os resultados / (soma = p0*num + p1*num)
              addi.s  $f9,$f9,1.0        #incrementa o numero a ser usado / num++
              j       VERIF              #pula para verif para repetir o while

FINAL:       
              jr      $ra  