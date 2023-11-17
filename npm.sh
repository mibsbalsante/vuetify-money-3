#!/bin/bash
#
######################################################################
#    FUNÇÃO SCRIPT.: COPIAR ARQUIVOS PARA O DIRETORIO npm            # 
#                    PUBLICAR COMPONENTE NO NPM                      #
#------------------------------------------------------------------- #
#                                                                    #
#       DESENVOLVIMENTO.: JUAREZ NASATO                              #
#       EMAIL.: JUAREZNASATO@GMAIL.COM                               #
#       DATA CRIACAO.: 11/05/2019                                    #
#       VERSAO.: 0.0.1                                               #
#                                                                    #
######################################################################
#
# --> COMANDOS <--
# $ npm login           login in npm
# $ sh npm.sh -pk       pack
# $ sh npm.sh -pb       publish
#
echo "\033[1;36m  #    # #####  #    #       #####  #    # #####  \033[0m";
echo "\033[1;36m  ##   # #    # ##  ##       #    # #    # #    # \033[0m";
echo "\033[1;36m  # #  # #    # # ## #       #    # #    # #    # \033[0m";
echo "\033[1;36m  #  # # #####  # #  #  ###  #####  #    # #####  \033[0m";
echo "\033[1;36m  #   ## #      #    #       #      #    # #    # \033[0m";
echo "\033[1;36m  #    # #      #    #       #      #    # #    # \033[0m";
echo "\033[1;36m  #    # #      #    #       #      ###### #####  \033[0m";
echo
echo "Copiando arquivos...";
mkdir -p npm/src/components
cp package.json npm;
cp README.md npm;
cp src/components/* npm/src/components;
cp lib/* npm;
echo "Copiado.";
if [ $1 = "-pk" ];
then
    echo "Empacotando arquivos...";
    npm pack ./npm;
    echo "Empacotado.";
fi;

if [ $1 = "-pb" ];
then
    echo "npm login...";
    npm login;
    echo "Publicando no npm...";
    npm publish ./npm;
    echo "Publicado."
fi;
echo "Excluindo arquivos...";
rm -r npm/*
echo "Arquivos excluidos.";
echo "Fim.";

