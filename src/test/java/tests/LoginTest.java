package tests;

import org.testng.annotations.Test;

public class LoginTest extends BaseTest {

    @Test
    public void checkRunNode() throws InterruptedException {
        walletPage.openLoginPage()
                .isLoginPageOpened()
                .closeAnotherTabs()
                .login(emailNine, password)
                .isCreatePinCodePageOpened()
                .createPinCode(newPassword)
                .isImportPageOpened()
                .importWallet(seedNine)
                .isImportWalletSuccessful();
        loginPage.openPage()
                .isOpened()
                .connectWallet()
                .signWallet()
                .runNode()
                .dailyCheck();
    }
}
