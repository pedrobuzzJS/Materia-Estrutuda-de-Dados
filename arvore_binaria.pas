Program Pzim ;  

	 type tree = ^node;
	    			node = record
	            dado: integer;
	            left: tree;
	            right: tree;
	         end;             
        
   function empityTree(var arv: tree):boolean;
	 begin
	    if (arv = nil) then
	       empityTree:= true                                                
	    else 
	       empityTree:= false;
	 end;     
				  
   procedure defineTree(var arv: tree);
   begin
      arv:=nil;
   end;
   
   procedure creatRoot(var arv: tree; var dado: integer);
   var node: tree;
   begin
      new(node);
      node^.left:= nil;
      node^.right:= nil;
      node^.dado:= dado;
      arv:= node;
   end;
   
   procedure insertTree(var arv: tree; var dado: integer);
   var node: tree;
   begin
      if (arv = nil) then
         begin
            new(node);
            node^.left:= nil;
            node^.dado:= dado;
            node^.right:= nil;
            arv:= node;
         end
       else
          if (dado < arv^.dado) then
             begin
                insertTree(arv^.left, dado);
             end;
          if (dado > arv^.dado) then
             begin
                insertTree(arv^.right, dado);
             end;
   end;
   
   procedure preOrder(var arv: tree);
   begin
      if (arv<>nil) then
         begin     
            write('  ',arv^.dado,'  ');         
            preOrder(arv^.left);             
            preOrder(arv^.right);
         end; 
   end;
   
   procedure inOrder(var arv: tree);
   begin
      if (arv<>nil) then
         begin                   
            inOrder(arv^.left); 
						write('  ',arv^.dado,'  ');            
            inOrder(arv^.right);
         end;
   end;
   
   procedure posOrder(var arv: tree);
   begin
      if (arv<>nil) then
         begin
            posOrder(arv^.left);
            posOrder(arv^.right);
            write('  ',arv^.dado,'  ');
         end;
   end;
   
   procedure search(var arv: tree; dado: integer);
   begin
      if (arv<>nil) then
         begin
            if (arv^.dado = dado) then
               begin
                  writeln('Elemento encrontrado');
                  readln;
               end
            else
               begin
                  if (dado < arv^.dado) then
                     search(arv^.left, dado)
                  else
                     search(arv^.right, dado);
               end;
         end;
   end;
   
   procedure deleteTree(var arv: tree);
   begin
      if (arv<>nil) then
         begin
            deleteTree(arv^.left);
            deleteTree(arv^.right);
            dispose(arv);
         end;
   end;
	 
	 function nivel(var arv: tree; var dado: integer): integer;
	 begin
	    if (arv = nil) then
	       begin
	          nivel:=0;
	       end
	    else
	       begin
	          if (dado < arv^.dado) then
	             begin
	                nivel:= nivel(arv^.left, dado) + 1;
	             end
	          else
	             begin
	                nivel:= nivel(arv^.right, dado) + 1;
	             end;
	       end;
	 end;
	 
	 function maior(a,b:integer):integer;
	 begin
	    if (a > b) then 
	       maior := a
	    else 
	       maior := b;
	 end;
		
	 function altura (arv:tree):integer;
	 begin
	    if (arv = nil) then 
			   altura := 0
	    else 
			   altura := 1+maior(altura(arv^.left),altura(arv^.right));
	 end;

   
   function nNodes(var arv: tree): integer;
   begin
      if (arv=nil) then
         nNodes:=0
      else
         nNodes:= 1+nNodes(arv^.left) + nNodes(arv^.right);
   end;    	 
     
   procedure completeTree(var altura, tamanho: integer);
   var alt, i: integer;
   begin
	    alt:=1;      
      for i:=1 to altura do
         begin
            alt:= alt*2;
         end;
      if ((alt-1) = tamanho) then                            
         begin
            writeln('Árvore completa!');
         end
      else
         begin
            writeln('Árvore incompleta!');
         end;
   end;  
   
   
   function removeNode(var arv: tree; var dado: integer):tree;
   var aux: tree;
   begin
      if(arv=nil) then
         begin
            writeln('Inexistente');
            removeNode:=nil;
         end
      else 
			   if(arv^.dado = dado) then
            begin
               if((arv^.left=nil) and (arv^.right=nil)) then
                  begin
                     dispose(arv);
                     removeNode:=nil;
                  end
               else
                  if((arv^.left=nil) or (arv^.right=nil)) then
                     begin
                        if(arv^.left<>nil) then
                           begin
                              aux:=arv^.left;
                           end
                        else
                           aux:=arv^.right;
                           removeNode:=aux;
                     end
                  else
                     begin
                        aux:=arv^.left;
                        while(aux^.right<>nil) do
                           begin
                              aux:=aux^.right;                              
                           end;
                         arv^.dado:=aux^.dado;
                         aux^.dado:=dado;
                         arv^.left:=removeNode(arv^.left, dado);
                         removeNode:=arv;
                     end;                  
            end
            else
                     begin
                        if(dado<arv^.dado) then
                           begin
                              arv^.left:=removeNode(arv^.left, dado);
                           end
                        else
                           begin
                              arv^.right:=removeNode(arv^.right, dado);
                           end;
                        removeNode:=arv;
                     end;
   end;
   
   

   
var root: tree;
var num, op, op2, procurar, c, elem, remover, n, tam, alt: integer;
var achou: boolean;


Begin
	 op:=1000; 
   begin
      while (op <> 0) do
      begin
         clrscr;
         writeln('||==================================================||');
         writeln('||= Árvore binária de busca                        =||');       
         writeln('||==================================================||');
         writeln('||= Adicionar dados na árvore                  (1) =||');
         writeln('||= Percorrer                                  (2) =||');
         writeln('||= Verificar se um elemento está na árvore    (3) =||');
         writeln('||= Informar Altura da Árvore                  (4) =||');
         writeln('||= Informar número de nós                     (5) =||');
         writeln('||= Informar Nível de um Elemento da Árvore    (6) =||');
         writeln('||= Informar se a árvore está completa ou não  (7) =||');
         writeln('||= Remover elemento da árvore                 (8) =||');
         writeln('||= Sair                                       (0) =||');
         writeln('||==================================================||');
         readln(op);
         case op of
            1: begin
						   writeln('Escreva o elemento desejado');
               readln(num);
							 insertTree(root, num);
							 end;  
						2: begin
									op2:=1000;
							    while (op2 <> 0) do
      						   begin									      
									      clrscr;
						            writeln('||======================================||');
         					      writeln('||= Percorrer árvore binária de busca  =||');       
			                  writeln('||======================================||');
			                  writeln('||= Percorrer pre_order            (1) =||');
			                  writeln('||= Percorrer in_order             (2) =||');
			                  writeln('||= Percorrer pos_order            (3) =||');			                  
			                  writeln('||= Sair                           (0) =||');
			                  writeln('||======================================||');
			                  readln(op2);
			                  case op2 of
			                     1: begin
			                           preOrder(root);
			                           readln;
			                        end;													 
			                     2: begin
			                           inOrder (root);
			                           readln;
			                        end;
			                     3: begin
			                           posOrder (root);
																 readln; 
			                        end; 			                     
                     		end;
                     end;
							 end;
						3: begin
									writeln;
									writeln;
						      writeln('Informe o elemento a ser procurado na árvore!');
						      readln(procurar);
						      search(root, procurar);
						   end;	
						4: begin
									writeln;
									writeln;
						      writeln('Altura da árvore');
						      writeln;
						      writeln(altura(root));
						      readln;
						   end;	
						5: begin
									writeln;
									writeln;
						      writeln('Número de nós');
						      writeln(nNodes(root));
						      readln;
						   end;
						6: begin
						      writeln;
						      writeln;
						      writeln('Elemento desejado');
						      readln(elem);
						      writeln(nivel(root, elem));
						      readln;
						   end;	
						7: begin
						      writeln;
						      writeln;
						      alt:= altura(root);
						      tam:= nNodes(root);
						      completeTree(alt, tam);
						      readln;
						   end;
						8: begin
						      writeln;
						      writeln('Qual dado deseja remover?');
									readln(remover);
									removeNode(root, remover);   
						   end;   						
         end;  
      end;
   end; 
End.