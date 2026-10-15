import '../models/workout.dart';
import '../models/exercise.dart';

class SpecialWorkoutsData {
  static List<WorkoutRoutine> getWorkouts() {
    return [
      // 1. PPL - Push
      WorkoutRoutine(
        id: 'spec_1',
        title: 'Push Day: Peito, Ombros & Tríceps',
        subtitle: 'Foco em força e hipertrofia de empurrar',
        categoryTag: 'Hipertrofia / PPL',
        estimatedMinutes: 55,
        exercises: [
          Exercise(id: 's1_e1', name: 'Supino Reto com Barra', muscleGroup: 'Peito', sets: 4, reps: '8-10', restSeconds: 90, weightKg: 80, notes: 'Descida lenta de 3s, cotovelos a 45º.'),
          Exercise(id: 's1_e2', name: 'Supino Inclinado com Halteres', muscleGroup: 'Peito', sets: 4, reps: '10-12', restSeconds: 75, weightKg: 28, notes: 'Banco inclinado a 30 graus.'),
          Exercise(id: 's1_e3', name: 'Crossover na Polia Média', muscleGroup: 'Peito', sets: 3, reps: '12-15', restSeconds: 60, weightKg: 25, notes: 'Pico de contração de 1s.'),
          Exercise(id: 's1_e4', name: 'Desenvolvimento Militar com Halteres', muscleGroup: 'Ombros', sets: 4, reps: '8-10', restSeconds: 75, weightKg: 22, notes: 'Sem impulso das pernas.'),
          Exercise(id: 's1_e5', name: 'Elevação Lateral com Halteres', muscleGroup: 'Ombros', sets: 4, reps: '12-15', restSeconds: 45, weightKg: 12, notes: 'Foco na cabeça lateral do deltoide.'),
          Exercise(id: 's1_e6', name: 'Tríceps Corda na Polia', muscleGroup: 'Tríceps', sets: 4, reps: '12-15', restSeconds: 45, weightKg: 35, notes: 'Abra a corda na contração máxima.'),
          Exercise(id: 's1_e7', name: 'Tríceps Francês com Halter', muscleGroup: 'Tríceps', sets: 3, reps: '10-12', restSeconds: 60, weightKg: 24, notes: 'Alongamento profundo da cabeça longa.'),
        ],
      ),

      // 2. PPL - Pull
      WorkoutRoutine(
        id: 'spec_2',
        title: 'Pull Day: Costas, Trapézio & Bíceps',
        subtitle: 'Construção de dorsais largas e espessura',
        categoryTag: 'Hipertrofia / PPL',
        estimatedMinutes: 55,
        exercises: [
          Exercise(id: 's2_e1', name: 'Levantamento Terra (Deadlift)', muscleGroup: 'Costas', sets: 4, reps: '6-8', restSeconds: 120, weightKg: 110, notes: 'Ativação completa da cadeia posterior.'),
          Exercise(id: 's2_e2', name: 'Puxada Alta com Pegada Aberta', muscleGroup: 'Costas', sets: 4, reps: '10-12', restSeconds: 75, weightKg: 65, notes: 'Concentre a força nos cotovelos.'),
          Exercise(id: 's2_e3', name: 'Remada Curvada com Barra', muscleGroup: 'Costas', sets: 4, reps: '8-10', restSeconds: 90, weightKg: 70, notes: 'Tronco firme e abdômen contraído.'),
          Exercise(id: 's2_e4', name: 'Remada Baixa no Triângulo', muscleGroup: 'Costas', sets: 3, reps: '12', restSeconds: 60, weightKg: 60, notes: 'Adução escapular no final do movimento.'),
          Exercise(id: 's2_e5', name: 'Encolhimento com Barra', muscleGroup: 'Costas', sets: 4, reps: '12-15', restSeconds: 45, weightKg: 80, notes: 'Segure 2s no topo do encolhimento.'),
          Exercise(id: 's2_e6', name: 'Rosca Direta com Barra W', muscleGroup: 'Bíceps', sets: 4, reps: '10-12', restSeconds: 60, weightKg: 32, notes: 'Sem balanço do tronco.'),
          Exercise(id: 's2_e7', name: 'Rosca Martelo com Halteres', muscleGroup: 'Bíceps', sets: 3, reps: '12', restSeconds: 45, weightKg: 16, notes: 'Foco em braquiorradial.'),
        ],
      ),

      // 3. PPL - Legs
      WorkoutRoutine(
        id: 'spec_3',
        title: 'Leg Day: Quadríceps, Posterior & Panturrilha',
        subtitle: 'Intensidade máxima de membros inferiores',
        categoryTag: 'Pernas / Membros Inferiores',
        estimatedMinutes: 60,
        exercises: [
          Exercise(id: 's3_e1', name: 'Agachamento Livre com Barra', muscleGroup: 'Pernas', sets: 4, reps: '8-10', restSeconds: 120, weightKg: 90, notes: 'Descida profunda controlada.'),
          Exercise(id: 's3_e2', name: 'Leg Press 45º', muscleGroup: 'Pernas', sets: 4, reps: '10-12', restSeconds: 90, weightKg: 220, notes: 'Pés na largura dos ombros sem travar o joelho.'),
          Exercise(id: 's3_e3', name: 'Cadeira Extensora', muscleGroup: 'Pernas', sets: 4, reps: '12-15', restSeconds: 60, weightKg: 70, notes: 'Segure 1s em extensão máxima.'),
          Exercise(id: 's3_e4', name: 'Mesa Flexora', muscleGroup: 'Pernas', sets: 4, reps: '10-12', restSeconds: 60, weightKg: 55, notes: 'Controle a fase excêntrica.'),
          Exercise(id: 's3_e5', name: 'Stiff com Halteres', muscleGroup: 'Pernas', sets: 4, reps: '10-12', restSeconds: 75, weightKg: 24, notes: 'Alongue o posterior com coluna neutra.'),
          Exercise(id: 's3_e6', name: 'Gêmeos em Pé (Panturrilha)', muscleGroup: 'Pernas', sets: 5, reps: '15-20', restSeconds: 45, weightKg: 60, notes: 'Alongamento total embaixo e contração no topo.'),
        ],
      ),

      // 4. Força Pura 5x5
      WorkoutRoutine(
        id: 'spec_4',
        title: 'Power 5x5: Força Bruta & Compostos',
        subtitle: 'O clássico programa de progressão de cargas',
        categoryTag: 'Força & Powerlifting',
        estimatedMinutes: 50,
        exercises: [
          Exercise(id: 's4_e1', name: 'Agachamento Livre', muscleGroup: 'Pernas', sets: 5, reps: '5', restSeconds: 180, weightKg: 100, notes: 'Carga pesada com técnica impecável.'),
          Exercise(id: 's4_e2', name: 'Supino Reto com Barra', muscleGroup: 'Peito', sets: 5, reps: '5', restSeconds: 180, weightKg: 90, notes: 'Pausa de 1s no peitoral.'),
          Exercise(id: 's4_e3', name: 'Remada Curvada Pendlay Row', muscleGroup: 'Costas', sets: 5, reps: '5', restSeconds: 150, weightKg: 80, notes: 'Barra toca o chão a cada repetição.'),
        ],
      ),

      // 5. Arnold Split - Peito & Costas
      WorkoutRoutine(
        id: 'spec_5',
        title: 'Arnold Golden Era: Peito & Costas Antagônicos',
        subtitle: 'Super-séries clássicas para pump extremo',
        categoryTag: 'Hipertrofia Clássica',
        estimatedMinutes: 60,
        exercises: [
          Exercise(id: 's5_e1', name: 'Supino Inclinado com Barra', muscleGroup: 'Peito', sets: 4, reps: '10', restSeconds: 75, weightKg: 75, notes: 'Super-série com Barra Fixa.'),
          Exercise(id: 's5_e2', name: 'Barra Fixa com Peso do Corpo', muscleGroup: 'Costas', sets: 4, reps: '8-10', restSeconds: 75, weightKg: 0, notes: 'Extensão completa dos braços.'),
          Exercise(id: 's5_e3', name: 'Crucifixo Reto com Halteres', muscleGroup: 'Peito', sets: 4, reps: '12', restSeconds: 60, weightKg: 18, notes: 'Super-série com Remada Cavalinho.'),
          Exercise(id: 's5_e4', name: 'Remada Cavalinho (T-Bar)', muscleGroup: 'Costas', sets: 4, reps: '10-12', restSeconds: 60, weightKg: 60, notes: 'Puxe com força no abdômen.'),
          Exercise(id: 's5_e5', name: 'Pullover com Halter', muscleGroup: 'Costas', sets: 3, reps: '15', restSeconds: 60, weightKg: 26, notes: 'Expande a caixa torácica e trabalha grande dorsal.'),
        ],
      ),

      // 6. Calistenia em Casa
      WorkoutRoutine(
        id: 'spec_6',
        title: 'Calistenia em Casa: Zero Equipamento',
        subtitle: 'Domínio do peso corporal e queima calórica',
        categoryTag: 'Calistenia / Em Casa',
        estimatedMinutes: 35,
        exercises: [
          Exercise(id: 's6_e1', name: 'Flexão de Braço Padrão', muscleGroup: 'Peito', sets: 4, reps: '15-20', restSeconds: 45, notes: 'Corpo em linha reta dos pés à cabeça.'),
          Exercise(id: 's6_e2', name: 'Agachamento com Salto (Jump Squat)', muscleGroup: 'Pernas', sets: 4, reps: '15', restSeconds: 45, notes: 'Amorteça a queda suavemente.'),
          Exercise(id: 's6_e3', name: 'Mergulho em Cadeira / Banco (Tríceps)', muscleGroup: 'Tríceps', sets: 4, reps: '15-20', restSeconds: 45, notes: 'Cotovelos para trás.'),
          Exercise(id: 's6_e4', name: 'Avanço / Passada Estática', muscleGroup: 'Pernas', sets: 3, reps: '12 cada perna', restSeconds: 45, notes: 'Joelho quase encostando no chão.'),
          Exercise(id: 's6_e5', name: 'Prancha Isométrica', muscleGroup: 'Abdômen', sets: 4, reps: '45-60s', restSeconds: 30, notes: 'Contraia glúteos e abdômen.'),
          Exercise(id: 's6_e6', name: 'Mountain Climbers', muscleGroup: 'Abdômen', sets: 4, reps: '40 segundos', restSeconds: 30, notes: 'Ritmo rápido e acelerado.'),
        ],
      ),

      // 7. HIIT Queima Gordura 20 Min
      WorkoutRoutine(
        id: 'spec_7',
        title: 'HIIT Queima Rápida 20 Minutos',
        subtitle: 'Acelere o metabolismo e o gasto calórico pós-treino',
        categoryTag: 'Cardio & Queima',
        estimatedMinutes: 20,
        exercises: [
          Exercise(id: 's7_e1', name: 'Burpees Completos', muscleGroup: 'Corrida', sets: 5, reps: '30s ativo', restSeconds: 30, notes: 'Explosão máxima na subida.'),
          Exercise(id: 's7_e2', name: 'Polichinelos com Ritmo Acelerado', muscleGroup: 'Corrida', sets: 5, reps: '45s ativo', restSeconds: 15, notes: 'Braços e pernas bem coordenados.'),
          Exercise(id: 's7_e3', name: 'Corrida Estacionária com Joelho Alto', muscleGroup: 'Corrida', sets: 5, reps: '30s ativo', restSeconds: 30, notes: 'Suba o joelho na altura do quadril.'),
          Exercise(id: 's7_e4', name: 'Agachamento com Salto', muscleGroup: 'Pernas', sets: 5, reps: '30s ativo', restSeconds: 30, notes: 'Gasto calórico intenso.'),
        ],
      ),

      // 8. Glúteo & Posterior Turbinado
      WorkoutRoutine(
        id: 'spec_8',
        title: 'Glúteos & Isquiotibiais de Elite',
        subtitle: 'Volume e modelagem da região posterior e glúteos',
        categoryTag: 'Glúteo & Posterior',
        estimatedMinutes: 50,
        exercises: [
          Exercise(id: 's8_e1', name: 'Elevação Pélvica com Barra', muscleGroup: 'Pernas', sets: 4, reps: '10-12', restSeconds: 90, weightKg: 80, notes: 'Pausa de 2s no ponto mais alto.'),
          Exercise(id: 's8_e2', name: 'Búlgaro com Halteres', muscleGroup: 'Pernas', sets: 3, reps: '10 cada perna', restSeconds: 75, weightKg: 16, notes: 'Tronco ligeiramente inclinado à frente.'),
          Exercise(id: 's8_e3', name: 'Stiff Unilateral com Halter', muscleGroup: 'Pernas', sets: 3, reps: '12 cada perna', restSeconds: 60, weightKg: 14, notes: 'Foco total no posterior de coxa.'),
          Exercise(id: 's8_e4', name: 'Cadeira Abdutora (Drop-set)', muscleGroup: 'Pernas', sets: 4, reps: '15 + 10 drop', restSeconds: 60, weightKg: 65, notes: 'Tronco inclinado para frente.'),
          Exercise(id: 's8_e5', name: 'Glúteo no Cabo / Polia Baixa', muscleGroup: 'Pernas', sets: 3, reps: '15 cada lado', restSeconds: 45, weightKg: 20, notes: 'Contração isométrica de 1s.'),
        ],
      ),

      // 9. Braços Gigantes: Super-Sets Bíceps & Tríceps
      WorkoutRoutine(
        id: 'spec_9',
        title: 'Braços 3D: Bi-Set de Bíceps e Tríceps',
        subtitle: 'Bombardeio com super-séries para braços densos',
        categoryTag: 'Braços & Hipertrofia',
        estimatedMinutes: 45,
        exercises: [
          Exercise(id: 's9_e1', name: 'Rosca Direta com Barra Reta', muscleGroup: 'Bíceps', sets: 4, reps: '10', restSeconds: 60, weightKg: 35, notes: 'Alterne direto com Tríceps Testa.'),
          Exercise(id: 's9_e2', name: 'Tríceps Testa com Barra W', muscleGroup: 'Tríceps', sets: 4, reps: '10', restSeconds: 60, weightKg: 32, notes: 'Execução estrita sem abrir cotovelos.'),
          Exercise(id: 's9_e3', name: 'Rosca Scott na Máquina', muscleGroup: 'Bíceps', sets: 4, reps: '12', restSeconds: 60, weightKg: 40, notes: 'Alongamento sem estalar cotovelo.'),
          Exercise(id: 's9_e4', name: 'Tríceps Pulley com Barra V', muscleGroup: 'Tríceps', sets: 4, reps: '12', restSeconds: 60, weightKg: 45, notes: 'Extensão completa para baixo.'),
          Exercise(id: 's9_e5', name: 'Rosca Martelo na Corda', muscleGroup: 'Bíceps', sets: 3, reps: '15', restSeconds: 45, weightKg: 30, notes: 'Foco em antebraço e braquial.'),
          Exercise(id: 's9_e6', name: 'Mergulho nas Paralelas', muscleGroup: 'Tríceps', sets: 3, reps: '12-15', restSeconds: 60, weightKg: 0, notes: 'Corpo vertical para foco em tríceps.'),
        ],
      ),

      // 10. Desafio Corrida 5KM
      WorkoutRoutine(
        id: 'spec_10',
        title: 'Corrida 5KM: Treino de Tiro & Resistência',
        subtitle: 'Construa ritmo constante e fôlego de aço',
        categoryTag: 'Cardio & Corrida',
        estimatedMinutes: 35,
        exercises: [
          Exercise(id: 's10_e1', name: 'Aquecimento: Trote Leve', muscleGroup: 'Corrida', sets: 1, reps: '5 minutos', restSeconds: 60, notes: 'Frequência cardíaca subindo gradualmente.'),
          Exercise(id: 's10_e2', name: 'Tiro de 400m em Ritmo de Prova', muscleGroup: 'Corrida', sets: 6, reps: '400m sprint forte', restSeconds: 60, notes: '1 min de caminhada de recuperação entre tiros.'),
          Exercise(id: 's10_e3', name: 'Corrida Contínua Moderada', muscleGroup: 'Corrida', sets: 1, reps: '15 minutos (pace constante)', restSeconds: 60, notes: 'Mantenha respiração ritmada 2x2.'),
          Exercise(id: 's10_e4', name: 'Desaquecimento e Trote Suave', muscleGroup: 'Corrida', sets: 1, reps: '5 minutos', restSeconds: 60, notes: 'Retorno gradual à calma.'),
        ],
      ),

      // 11. Abdômen Trincado & Vácuo
      WorkoutRoutine(
        id: 'spec_11',
        title: 'Core de Ferro & Definição Abdominal',
        subtitle: 'Trabalho completo de reto, oblíquos e transverso',
        categoryTag: 'Core & Abdômen',
        estimatedMinutes: 25,
        exercises: [
          Exercise(id: 's11_e1', name: 'Stomach Vacuum (Vácuo Abdominal)', muscleGroup: 'Abdômen', sets: 4, reps: '20 segundos sustentado', restSeconds: 30, notes: 'Solte todo o ar e puxe o umbigo para as costas.'),
          Exercise(id: 's11_e2', name: 'Elevação de Pernas na Barra Fixa', muscleGroup: 'Abdômen', sets: 4, reps: '12-15', restSeconds: 45, notes: 'Sem balançar o corpo, eleve até a altura do peito.'),
          Exercise(id: 's11_e3', name: 'Abdominal no Cabo (Rope Crunch)', muscleGroup: 'Abdômen', sets: 4, reps: '15-20', restSeconds: 45, weightKg: 40, notes: 'Enrole a coluna contraindo o abdômen.'),
          Exercise(id: 's11_e4', name: 'Prancha Lateral com Elevação de Quadril', muscleGroup: 'Abdômen', sets: 3, reps: '12 cada lado', restSeconds: 30, notes: 'Foco nos oblíquos.'),
          Exercise(id: 's11_e5', name: 'Abdominal Bicicleta (Air Bike)', muscleGroup: 'Abdômen', sets: 3, reps: '30 segundos contínuos', restSeconds: 30, notes: 'Cotovelo oposto ao joelho.'),
        ],
      ),

      // 12. Deltoides 3D: Ombros Completos
      WorkoutRoutine(
        id: 'spec_12',
        title: 'Ombros 3D: Deltoide Anterior, Lateral & Posterior',
        subtitle: 'Aspecto largo e tridimensional para a silhueta',
        categoryTag: 'Ombros & Deltoides',
        estimatedMinutes: 45,
        exercises: [
          Exercise(id: 's12_e1', name: 'Desenvolvimento com Halteres no Banco', muscleGroup: 'Ombros', sets: 4, reps: '8-10', restSeconds: 75, weightKg: 24, notes: 'Amplitude total sem encostar os halteres no topo.'),
          Exercise(id: 's12_e2', name: 'Elevação Lateral na Polia Baixa', muscleGroup: 'Ombros', sets: 4, reps: '12-15 cada braço', restSeconds: 45, weightKg: 10, notes: 'Tensão constante em todo o arco.'),
          Exercise(id: 's12_e3', name: 'Crucifixo Invertido no Banco Inclinado', muscleGroup: 'Ombros', sets: 4, reps: '15', restSeconds: 45, weightKg: 12, notes: 'Foco no deltoide posterior.'),
          Exercise(id: 's12_e4', name: 'Face Pull na Polia Alta', muscleGroup: 'Ombros', sets: 4, reps: '15-20', restSeconds: 45, weightKg: 30, notes: 'Puxe a corda em direção aos olhos rodando os punhos.'),
          Exercise(id: 's12_e5', name: 'Elevação Frontal com Anilhas', muscleGroup: 'Ombros', sets: 3, reps: '12', restSeconds: 45, weightKg: 15, notes: 'Suba até a linha dos olhos.'),
        ],
      ),

      // 13. Treino Express 15 Minutos
      WorkoutRoutine(
        id: 'spec_13',
        title: 'Treino Express: 15 Minutos Sem Desculpas',
        subtitle: 'Para dias corridos: ativação total do corpo',
        categoryTag: 'Express / Rápido',
        estimatedMinutes: 15,
        exercises: [
          Exercise(id: 's13_e1', name: 'Agachamento com Peso do Corpo', muscleGroup: 'Pernas', sets: 3, reps: '25 reps', restSeconds: 20, notes: 'Ritmo cadenciado sem parar.'),
          Exercise(id: 's13_e2', name: 'Flexão de Braços', muscleGroup: 'Peito', sets: 3, reps: '15 reps', restSeconds: 20, notes: 'Peito quase toca o solo.'),
          Exercise(id: 's13_e3', name: 'Polichinelos Rápidos', muscleGroup: 'Corrida', sets: 3, reps: '40 segundos', restSeconds: 20, notes: 'Elevação de frequência cardíaca.'),
          Exercise(id: 's13_e4', name: 'Prancha Isométrica', muscleGroup: 'Abdômen', sets: 3, reps: '45 segundos', restSeconds: 20, notes: 'Trave todo o corpo.'),
        ],
      ),

      // 14. Peitoral Monstro
      WorkoutRoutine(
        id: 'spec_14',
        title: 'Peitoral Completo: Densidade & Amplitude',
        subtitle: 'Trabalho de todas as porções do peitoral',
        categoryTag: 'Peito & Superior',
        estimatedMinutes: 50,
        exercises: [
          Exercise(id: 's14_e1', name: 'Supino Inclinado com Barra', muscleGroup: 'Peito', sets: 4, reps: '8-10', restSeconds: 90, weightKg: 75, notes: 'Foco na porção clavicular.'),
          Exercise(id: 's14_e2', name: 'Supino Reto com Halteres', muscleGroup: 'Peito', sets: 4, reps: '10', restSeconds: 75, weightKg: 30, notes: 'Maior amplitude que a barra.'),
          Exercise(id: 's14_e3', name: 'Paralelas com Peso do Corpo', muscleGroup: 'Peito', sets: 3, reps: '10-12', restSeconds: 60, weightKg: 0, notes: 'Tronco inclinado para frente.'),
          Exercise(id: 's14_e4', name: 'Voador / Peck Deck', muscleGroup: 'Peito', sets: 4, reps: '12-15', restSeconds: 45, weightKg: 50, notes: 'Pausa de 2s na contração máxima.'),
          Exercise(id: 's14_e5', name: 'Flexões até a Falha', muscleGroup: 'Peito', sets: 2, reps: 'Falha concêntrica', restSeconds: 60, notes: 'Esgotamento final de fibras.'),
        ],
      ),

      // 15. Dorsais em V (Asas Abertas)
      WorkoutRoutine(
        id: 'spec_15',
        title: 'Dorsais em V: Amplitude & Costas Largas',
        subtitle: 'Foco na abertura das grandes dorsais',
        categoryTag: 'Costas & Superior',
        estimatedMinutes: 50,
        exercises: [
          Exercise(id: 's15_e1', name: 'Barra Fixa com Pegada Pronada', muscleGroup: 'Costas', sets: 4, reps: '8-10', restSeconds: 90, notes: 'Puxe o peito em direção à barra.'),
          Exercise(id: 's15_e2', name: 'Puxada Triângulo na Polia Alta', muscleGroup: 'Costas', sets: 4, reps: '10-12', restSeconds: 60, weightKg: 65, notes: 'Extensão completa no topo.'),
          Exercise(id: 's15_e3', name: 'Remada Serrote com Halter', muscleGroup: 'Costas', sets: 4, reps: '10 cada lado', restSeconds: 60, weightKg: 32, notes: 'Puxe o halter na direção do quadril.'),
          Exercise(id: 's15_e4', name: 'Pulldown com Corda no Cross', muscleGroup: 'Costas', sets: 4, reps: '15', restSeconds: 45, weightKg: 35, notes: 'Braços semi-estendidos.'),
          Exercise(id: 's15_e5', name: 'Hiperextensão Lombar no Banco', muscleGroup: 'Costas', sets: 3, reps: '15', restSeconds: 45, notes: 'Fortalecimento da cadeia baixa.'),
        ],
      ),

      // 16. Mobilidade & Alongamento Global
      WorkoutRoutine(
        id: 'spec_16',
        title: 'Mobilidade & Flexibilidade de Recuperação',
        subtitle: 'Soltura articular para evitar lesões e melhorar amplitude',
        categoryTag: 'Mobilidade & Saúde',
        estimatedMinutes: 30,
        exercises: [
          Exercise(id: 's16_e1', name: 'Alongamento em Posição de Pombo (Glúteos)', muscleGroup: 'Pernas', sets: 3, reps: '45s cada perna', restSeconds: 20, notes: 'Respire fundo e relaxe na postura.'),
          Exercise(id: 's16_e2', name: 'Cão Olhando para Baixo (Alongamento Posterior)', muscleGroup: 'Pernas', sets: 3, reps: '40 segundos', restSeconds: 20, notes: 'Calcanhares em direção ao chão.'),
          Exercise(id: 's16_e3', name: 'Mobilidade Torácica no Solo (Cat-Cow)', muscleGroup: 'Costas', sets: 3, reps: '15 ciclos lentos', restSeconds: 20, notes: 'Mobilize cada vértebra da coluna.'),
          Exercise(id: 's16_e4', name: 'Abertura de Quadril em Agachamento Cócoras', muscleGroup: 'Pernas', sets: 3, reps: '60 segundos sustentado', restSeconds: 30, notes: 'Cotovelos empurram os joelhos para fora.'),
          Exercise(id: 's16_e5', name: 'Alongamento de Peitoral e Bíceps na Parede', muscleGroup: 'Peito', sets: 2, reps: '30s cada braço', restSeconds: 15, notes: 'Giro suave do tronco.'),
        ],
      ),

      // 17. Funcional & Kettlebell
      WorkoutRoutine(
        id: 'spec_17',
        title: 'Treino Funcional: Kettlebell & Agilidade',
        subtitle: 'Condicionamento físico, explosão e estabilidade',
        categoryTag: 'Funcional & Cross',
        estimatedMinutes: 40,
        exercises: [
          Exercise(id: 's17_e1', name: 'Kettlebell Swing Russo', muscleGroup: 'Pernas', sets: 4, reps: '20 reps', restSeconds: 45, weightKg: 20, notes: 'Explosão de quadril sem usar braços.'),
          Exercise(id: 's17_e2', name: 'Thruster com Halteres (Agacha + Desenvolve)', muscleGroup: 'Pernas', sets: 4, reps: '12 reps', restSeconds: 60, weightKg: 14, notes: 'Movimento contínuo fluido.'),
          Exercise(id: 's17_e3', name: 'Caminhada do Fazendeiro (Farmer Walk)', muscleGroup: 'Costas', sets: 3, reps: '40 metros', restSeconds: 60, weightKg: 28, notes: 'Coluna ereta e pegada firme.'),
          Exercise(id: 's17_e4', name: 'Box Jump / Salto na Caixa', muscleGroup: 'Pernas', sets: 4, reps: '10 saltos', restSeconds: 45, notes: 'Pouse suavemente em semi-agachamento.'),
          Exercise(id: 's17_e5', name: 'Abdominal Russo (Russian Twist) com Peso', muscleGroup: 'Abdômen', sets: 3, reps: '20 giros', restSeconds: 30, weightKg: 8, notes: 'Pés elevados do solo.'),
        ],
      ),

      // 18. Tabata Extremo
      WorkoutRoutine(
        id: 'spec_18',
        title: 'Protocolo Tabata: 8 Rounds de Fogo',
        subtitle: '20 segundos na intensidade máxima por 10 segundos de descanso',
        categoryTag: 'Cardio & Tabata',
        estimatedMinutes: 20,
        exercises: [
          Exercise(id: 's18_e1', name: 'Round 1 & 2: Burpees Explosivos', muscleGroup: 'Corrida', sets: 2, reps: '20s on / 10s off', restSeconds: 10, notes: 'Intensidade máxima absoluta.'),
          Exercise(id: 's18_e2', name: 'Round 3 & 4: Agachamento com Salto', muscleGroup: 'Pernas', sets: 2, reps: '20s on / 10s off', restSeconds: 10, notes: 'Sem diminuir o ritmo.'),
          Exercise(id: 's18_e3', name: 'Round 5 & 6: Mountain Climbers', muscleGroup: 'Abdômen', sets: 2, reps: '20s on / 10s off', restSeconds: 10, notes: 'Velocidade nos joelhos.'),
          Exercise(id: 's18_e4', name: 'Round 7 & 8: High Knees (Corrida no Lugar)', muscleGroup: 'Corrida', sets: 2, reps: '20s on / 10s off', restSeconds: 10, notes: 'Sprint final esgotando o tanque.'),
        ],
      ),

      // 19. Antebraço & Pegada de Aço
      WorkoutRoutine(
        id: 'spec_19',
        title: 'Pegada de Ferro: Antebraço & Punhos',
        subtitle: 'Aumento de força de sustentação e volume dos antebraços',
        categoryTag: 'Antebraço & Força',
        estimatedMinutes: 30,
        exercises: [
          Exercise(id: 's19_e1', name: 'Sustentação na Barra Fixa (Dead Hang)', muscleGroup: 'Costas', sets: 4, reps: 'Até a falha (40-60s)', restSeconds: 60, notes: 'Apenas os dedos segurando todo o peso.'),
          Exercise(id: 's19_e2', name: 'Rosca Punho com Barra', muscleGroup: 'Bíceps', sets: 4, reps: '15-20', restSeconds: 45, weightKg: 20, notes: 'Antebraços apoiados nas coxas.'),
          Exercise(id: 's19_e3', name: 'Rosca Inversa com Barra W', muscleGroup: 'Bíceps', sets: 4, reps: '12', restSeconds: 45, weightKg: 22, notes: 'Pegada pronada focando no extensor do punho.'),
          Exercise(id: 's19_e4', name: 'Pinch Grip (Segurar anilhas com a ponta dos dedos)', muscleGroup: 'Bíceps', sets: 3, reps: '30s cada mão', restSeconds: 45, weightKg: 10, notes: 'Aperto estrito de pinça.'),
        ],
      ),

      // 20. Pernas Foco Posterior & Stiff Day
      WorkoutRoutine(
        id: 'spec_20',
        title: 'Posterior & Glúteo Avançado: Cadeia Posterior',
        subtitle: 'Foco nos isquiotibiais, lombar forte e glúteo',
        categoryTag: 'Pernas / Posterior',
        estimatedMinutes: 50,
        exercises: [
          Exercise(id: 's20_e1', name: 'Stiff Pesado com Barra Olímpica', muscleGroup: 'Pernas', sets: 4, reps: '8-10', restSeconds: 90, weightKg: 85, notes: 'Coluna 100% alinhada sentindo esticar o posterior.'),
          Exercise(id: 's20_e2', name: 'Mesa Flexora com Isometria', muscleGroup: 'Pernas', sets: 4, reps: '10 reps (segura 2s)', restSeconds: 60, weightKg: 50, notes: 'Não deixe o quadril descolar do banco.'),
          Exercise(id: 's20_e3', name: 'Elevação Pélvica Unilateral', muscleGroup: 'Pernas', sets: 3, reps: '12 cada perna', restSeconds: 60, weightKg: 15, notes: 'Ativação profunda de glúteo médio.'),
          Exercise(id: 's20_e4', name: 'Cadeira Flexora Sentada', muscleGroup: 'Pernas', sets: 4, reps: '12-15', restSeconds: 45, weightKg: 60, notes: 'Controle a volta em 3 segundos.'),
          Exercise(id: 's20_e5', name: 'Panturrilha Sentado (Solear)', muscleGroup: 'Pernas', sets: 4, reps: '15-20', restSeconds: 45, weightKg: 45, notes: 'Foco no músculo sóleo profundo.'),
        ],
      ),

      // 21. Desafio 100 Flexões & Abdominais
      WorkoutRoutine(
        id: 'spec_21',
        title: 'Desafio Centurião: 100 Flexões & 100 ABS',
        subtitle: 'Teste de resistência mental e muscular',
        categoryTag: 'Desafio Especial',
        estimatedMinutes: 25,
        exercises: [
          Exercise(id: 's21_e1', name: 'Flexões de Braço (Meta 100)', muscleGroup: 'Peito', sets: 5, reps: '20 reps (total 100)', restSeconds: 60, notes: 'Divida em 5 séries perfeitas.'),
          Exercise(id: 's21_e2', name: 'Abdominais Remador (Meta 100)', muscleGroup: 'Abdômen', sets: 5, reps: '20 reps (total 100)', restSeconds: 60, notes: 'Abra e feche o tronco com energia.'),
          Exercise(id: 's21_e3', name: 'Prancha Final de Honra', muscleGroup: 'Abdômen', sets: 1, reps: '2 minutos sustentados', restSeconds: 60, notes: 'Segure firme sem deixar o quadril cair.'),
        ],
      ),
    ];
  }
}
