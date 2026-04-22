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
            testCase.verifyTrue(simOut.hasElement('yout'), ...
                'Simulation should log output signals.');
        end
    end
end
