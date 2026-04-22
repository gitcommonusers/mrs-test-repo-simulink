classdef tMyModel < matlab.unittest.TestCase
      methods (TestMethodSetup)
          function loadModel(~)
              load_system('myModel');
          end
      end

      methods (TestMethodTeardown)
          function closeModel(~)
              close_system('myModel', 0);
          end
      end

      methods (Test)
          function testModelLoads(testCase)
              % Verify the model is loaded
              testCase.verifyTrue(bdIsLoaded('myModel'), ...
                  'Model should be loaded.');
          end

          function testSimulation(testCase)
              % Run simulation and verify it completes
              simOut = sim('myModel', 'StopTime', '10');
              testCase.verifyNotEmpty(simOut, ...
                  'Simulation should produce output.');
          end

          function testOutputSignal(testCase)
              % Run and check output signal exists
              simOut = sim('myModel', 'StopTime', '10');
              logged = simOut.who;
              testCase.verifyTrue(any(strcmp(logged, 'yout')), ...
                  'Simulation should log yout signal.');
          end
      end
  end
