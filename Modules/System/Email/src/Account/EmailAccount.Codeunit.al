// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------

/// <summary>
/// Provides functionality to work with email accounts.
/// </summary>
codeunit 8894 "Email Account"
{
    Access = Public;

    /// <summary>
    /// Gets all of the email accounts registered in Business Central.
    /// </summary>
    /// <param name="LoadLogos">Flag, used to determine whether to load the logos for the accounts.</param>
    /// <param name="Accounts">Out parameter holding the email accounts.</param>
    procedure GetAllAccounts(LoadLogos: Boolean; var Accounts: Record "Email Account" temporary)
    begin
        EmailAccountImpl.GetAllAccounts(LoadLogos, Accounts);
    end;

    /// <summary>
    /// Gets all of the email accounts registered in Business Central.
    /// </summary>
    /// <param name="Accounts">Out parameter holding the email accounts.</param>
    procedure GetAllAccounts(var Accounts: Record "Email Account" temporary)
    begin
        EmailAccountImpl.GetAllAccounts(false, Accounts);
    end;

    /// <summary>
    /// Checks if there is at least one email account registered in Business Central.
    /// </summary>
    /// <returns>True if there is any account registered in the system, otherwise - false.</returns>
    procedure IsAnyAccountRegistered(): Boolean
    begin
        exit(EmailAccountImpl.IsAnyAccountRegistered());
    end;

    /// <summary>
    /// Validates an email address and throws an error if it is invalid.
    /// </summary>
    /// <remarks>If the provided email address is an empty string, the function will do nothing.</remarks>
    /// <param name="EmailAddress">The email address to validate.</param>
    /// <error>The email address "%1" is not valid.</error>
    /// <returns>True if the email address is valid; false otherwise.</returns>
    [TryFunction]
    procedure ValidateEmailAddress(EmailAddress: Text)
    begin
        EmailAccountImpl.ValidateEmailAddress(EmailAddress, true);
    end;

    /// <summary>
    /// Validates an email address and throws an error if it is invalid.
    /// </summary>
    /// <param name="EmailAddress">The email address to validate.</param>
    /// <param name="AllowEmptyValue">Indicates whether to skip the validation if the provided email address is empty.</param>
    /// <error>The email address "%1" is not valid.</error>
    /// <error>The email address cannot be empty.</error>
    /// <returns>True if the email address is valid; false otherwise.</returns>
    [TryFunction]
    procedure ValidateEmailAddress(EmailAddress: Text; AllowEmptyValue: Boolean)
    begin
        EmailAccountImpl.ValidateEmailAddress(EmailAddress, AllowEmptyValue);
    end;

    var
        EmailAccountImpl: Codeunit "Email Account Impl.";
}