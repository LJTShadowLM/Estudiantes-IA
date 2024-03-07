class Estudiante:
    def __init__(self, nombre, nota, asistencia):
        self.nombre = nombre
        self.nota = nota
        self.asistencia = asistencia

    def evaluar_estudiante(self):
        if self.nota >= 60 and self.asistencia >= 80:
            print("El estudiante", self.nombre, "ha aprobado.")
        else:
            print("El estudiante", self.nombre, "ha desaprobado. Se sugiere un plan de acción para mejorar.")

max_estudiantes = 5
estudiantes = []

print("Ingrese la información de los estudiantes (nombre, nota, asistencia):")

count = 0
opcion = 's'
while (opcion.lower() == 's' and count < max_estudiantes):
    nombre = input("Nombre: ")
    nota = float(input("Nota: "))
    asistencia = int(input("Asistencia (%): "))

    if 0 <= nota <= 100 and 0 <= asistencia <= 100:
        estudiante = Estudiante(nombre, nota, asistencia)
        estudiantes.append(estudiante)
        count += 1
    else:
        print("Error: Por favor, ingrese valores válidos para promedio y asistencia (entre 0 y 100).")

    if count < max_estudiantes:
        opcion = input("¿Desea ingresar otro estudiante? (s/n): ")

print("\nRESULTADOS DE LA EVALUACIÓN:")
for estudiante in estudiantes:
    estudiante.evaluar_estudiante()
