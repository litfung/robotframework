*** Settings ***
Library    skiplib.py

*** Variables ***
${TEST_OR_TASK}    Test

*** Test Cases ***
Skip Keyword
    [Documentation]    SKIP Skipped with Skip keyword.
    Skip
    Fail    Should not be executed!

Skip with Library Keyword
    [Documentation]    SKIP Show must not got on
    Skip with Message    Show must not got on
    Fail    Should not be executed!

Skip If Keyword with True Condition
    [Documentation]    SKIP 1 == 1
    Skip If    1 == 1

Skip If Keyword with True Condition And Custom Message
    [Documentation]    SKIP Skipped with abandon.
    Skip If    1 == 1    Skipped with abandon.

Skip If Keyword with False Condition
    [Documentation]    FAIL AssertionError
    Skip If    1 == 2
    Fail

Skip Keyword with Custom Message
    [Documentation]    SKIP Skipped due to reasons
    Skip    Skipped due to reasons
    Fail    Should not be executed!

Skip in Setup
    [Documentation]    SKIP Setup skip
    [Setup]    Skip    Setup skip
    Fail    Should not be executed!

Remaining setup keywords aren't run after skip
    [Documentation]    SKIP Skip between keywords
    [Setup]    Skip with keywords before and after
    Fail    Should not be executed!

Skip in Teardown
    [Documentation]    SKIP Teardown skip
    No operation
    [Teardown]    Skip    Teardown skip

Remaining teardown keywords aren't run after skip
    [Documentation]    SKIP Skip between keywords
    No operation
    [Teardown]    Skip with keywords before and after

Skip in Teardown After Failure In Body
    # FIXME: Should show failure message in the final message as well.
    [Documentation]    SKIP Teardown skip
    Fail    Failure in body!
    [Teardown]    Skip    Teardown skip

Teardown is executed after skip
    [Documentation]    SKIP Skip in body
    Skip    Skip in body
    [Teardown]    Log    Teardown is executed!

Fail in Teardown After Skip In Body
    # FIXME: This test doesn't pass at the moment. Status should be SKIP
    # but the final error message should also contain the teardown failure.
    [Documentation]    SKIP FIXME
    Skip    Skip in body
    [Teardown]    Fail    Teardown failed!

Skip in Teardown After Skip In Body
    # FIXME: Should probably show both skip messages in the final message.
    [Documentation]    SKIP Teardown skip
    Skip    Skip in body
    [Teardown]    Skip    Teardown skip

Skip with Continuable Failures
    # FIXME: This test doesn't pass at the moment. Status should be SKIP
    # but the final error message should also contain earlier failures.
    [Documentation]    SKIP FIXME
    Run Keyword And Continue On Failure
    ...    Fail    We can continue!
    Run Keyword And Continue On Failure
    ...    Fail    We can continue again!
    Skip    Skipping should stop execution but test should still fail
    Fail    Should not be executed!

Skipped with --skip
    [Tags]   skip-this
    [Documentation]    SKIP ${TEST_OR_TASK} skipped with --skip command line option.
    Fail

Skipped with --SkipOnFailure
    [Tags]   skip-on-failure
    [Documentation]    SKIP ${TEST_OR_TASK} skipped with --SkipOnFailure, original error:\nAssertionError
    Fail

--NonCritical Is an Alias for --SkipOnFailure
    [Tags]   non-crit
    [Documentation]    SKIP ${TEST_OR_TASK} skipped with --SkipOnFailure, original error:\nAssertionError
    Fail

--Critical can be used to override --SkipOnFailure
    [Tags]   dynamic-skip    crit
    [Documentation]    FAIL AssertionError
    Fail

Failing Test
    [Documentation]    FAIL AssertionError
    Fail

Passing Test
    No Operation

*** Keywords ***
Skip with keywords before and after
    No Operation
    Skip    Skip between keywords
    Fail    Should not be executed!
