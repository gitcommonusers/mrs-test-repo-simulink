function plan = buildfile
    plan = buildplan(localfunctions);
    plan("test").Dependencies = "codeIssues";
    plan.DefaultTasks = "test";
end

function codeIssuesTask(~)
    issues = codeIssues(pwd, IncludeSubfolders=true, FileTypes="code");
    assert(issues.ErrorCount == 0, "Found %d code errors", issues.ErrorCount);
end

function testTask(~)
    results = runtests(pwd, IncludeSubfolders=true);
    assertSuccess(results);
end
