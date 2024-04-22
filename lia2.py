from pyswip import Prolog

# Definir los estados válidos
estados_validos = ["bueno", "mal_estado"]

archivo = Prolog()
archivo.consult("C:/Users/beatr/OneDrive/Desktop/provest.pl")

print("Analicemos el estado de tu vestido por piezas (bueno/mal_estado)")

# Función para validar el estado ingresado
def validar_estado(estado):
    while estado not in estados_validos:
        print("Estado no válido. Por favor, introduce 'bueno' o 'mal_estado'.")
        estado = input(f"Introduce el estado: ")
    return estado

estado_falda = validar_estado(input("Introduce el estado de la falda: "))
estado_top = validar_estado(input("Introduce el estado del top: "))
estado_cinturon = validar_estado(input("Introduce el estado del cinturón: "))
estado_botones = validar_estado(input("Introduce el estado de los botones: "))

result = bool(list(archivo.query(f"irreparable({estado_falda},{estado_top},{estado_cinturon},{estado_botones})")))

print("El vestido tiene arreglo" if not result else "El vestido no tiene arreglo")

