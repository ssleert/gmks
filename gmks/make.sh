i#project info                                                                                                                                                                          
NAME='$_name'                                                                                                                                                                                  
MAIN_FILE='./cmd/$_name/$_name.go'                                                                                                                                                             
BIN_DIR='.'                                                                                                                                                                                    
VERSION='0.0.1'                                                                                                                                                                                
DEBUG='OFF'                                                                                                                                                                                    
                                                                                                                                                                                               
# gc type                                                                                                                                                                                      
GC='$_gc'                                                                                                                                                                                      
                                                                                                                                                                                               
# if gc is gcc                                                                                                                                                                                 
GCC_FLAGS='                                                                                                                                                                                    
  -mfpmath=sse                                                                                                                                                                                 
  -march=native                                                                                                                                                                                
  -Ofast                                                                                                                                                                                       
  -flto=auto                                                                                                                                                                                   
  -funroll-loops                                                                                                                                                                               
  -pipe                                                                                                                                                                                        
  -static                                                                                                                                                                                      
  -s                                                                                                                                                                                           
  -w                                                                                                                                                                                           
'                                                                                                                                                                                              
                                                                                                                                                                                               
# if gc is go                                                                                                                                                                                  
GO_LINKER_FLAGS='                                                                                                                                                                              
  -s                                                                                                                                                                                           
  -w                                                                                                                                                                                           
'                                                                                                                                                                                              
                                                                                                                                                                                               
# what tasks user can use                                                                                                                                                                      
# like phony in makefile                                                                                                                                                                       
TASKS='                                                                                                                                                                                        
  run                                                                                                                                                                                          
  prepare                                                                                                                                                                                      
  build                                                                                                                                                                                        
  strip                                                                                                                                                                                        
  install                                                                                                                                                                                      
  uninstall                                                                                                                                                                                    
  clean                                                                                                                                                                                        
'                                                                                                                                                                                              
                                                                                                                                                                                               
# tasks                                                                                                                                                                                        
                                                                                                                                                                                               
run() {                                                                                                                                                                                        
  _run \"\$@\"                                                                                                                                                                                 
}                                                                                                                                                                                              
                                                                                                                                                                                               
prepare() {                                                                                                                                                                                    
  _format                                                                                                                                                                                      
  _generate                                                                                                                                                                                    
}                                                                                                                                                                                              
                                                                                                                                                                                               
build() {                                                                                                                                                                                      
  _compile                                                                                                                                                                                     
}                                                                                                                                                                                              
                                                                                                                                                                                               
strip() {                                                                                                                                                                                      
  _strip                                                                                                                                                                                       
}                                                                                                                                                                                              
                                                                                                                                                                                               
install() {                                                                                                                                                                                    
  _install                                                                                                                                                                                     
}                                                                                                                                                                                              
                                                                                                                                                                                               
uninstall() {                                                                                                                                                                                  
  _uninstall                                                                                                                                                                                   
}                                                                                                                                                                                              
                                                                                                                                                                                               
clean() {                                                                                                                                                                                      
  _clean                                                                                                                                                                                       
}
