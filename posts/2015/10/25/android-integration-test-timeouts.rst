The main problem with Android CI I had recently is that, after switching
to Lollipop, the integration tests wouldn't run. Invoking
**androidConnectedTest** gradle target always resulted in crashing with
**ShellCommandUnresponsiveException**. Internet says that in such a case
ou just need to set **ADB\_INSTALL\_TIMEOUT**. Set and then nothing.
Sourcediving it is then ! 

A long while after that I got to this file:
`Device.java <https://android.googlesource.com/platform/tools/base/+/master/ddmlib/src/main/java/com/android/ddmlib/Device.java>`__ [Linking
to master, here's the commit
hash:1cb1a4c2976b99ae53d28d7f01d975232c85f990, as I don't seem to be
able to find how to link to that hash directly] What do we see there ?
That indeed **ADB\_INSTALL\_TIMEOUT** is being used: 

.. code-block:: java
   
    static {
        String installTimeout = System.getenv("ADB_INSTALL_TIMEOUT");
        long time = 4;
        if (installTimeout != null) {
            try {
                time = Long.parseLong(installTimeout);
            } catch (NumberFormatException e) {
                // use default value
            }
        }
        INSTALL_TIMEOUT_MINUTES = time;
    }

So far so good,
ADB\_INSTALL\_TIMEOUT system variable seems to be respected when
invoking package installation tools. Are the above the only methods that
can install a package though ? Going further on that hunch we see that
in addition to installing single packages there is a possibility of
having a multi-package installation session. 

.. code-block:: java

	public void installPackages(List<String> apkFilePaths, int timeOutInMs, boolean reinstall, String... extraArgs) throws InstallException {
	assert(!apkFilePaths.isEmpty());
	if (getApiLevel() < 21) {
		Log.w("Internal error : installPackages invoked with device < 21 for %s",Joiner.on(",").join(apkFilePaths));
		if (apkFilePaths.size() == 1) {
			installPackage(apkFilePaths.get(0), reinstall, extraArgs);
			return;
		}
		Log.e("Internal error : installPackages invoked with device < 21 for multiple APK : %s", Joiner.on(",").join(apkFilePaths));
		throw new InstallException("Internal error : installPackages invoked with device < 21 for multiple APK : " + Joiner.on(",").join(apkFilePaths));
	}
	[...]
	String sessionId = createMultiInstallSession(apkFilePaths, extraArgsList, reinstall);

Aha ! No-Lollipop check here, with a
fallback to the old method - we may be onto something ! Some lines pass
and we can see an invocation of **createMultiInstallSession**. What's
there ? 

.. code-block:: java

	private String createMultiInstallSession(List<String> apkFileNames, @NonNull Collection<String> extraArgs, boolean reinstall) throws TimeoutException, AdbCommandRejectedException, ShellCommandUnresponsiveException, IOException {
	[...]
	String cmd = String.format("pm install-create %1$s -S %2$d", parameters.toString(), totalFileSize);
	executeShellCommand(cmd, receiver, DdmPreferences.getTimeOut());
	[...]

A different invocation of
**executeShellCommand**, now using **DdmPreferences.getTimeOut()** as a
timeout value source. Summarizing - this only happens if you install
multiple applications for your androidConnectedTest and you are using
android device to test on that has api version that is equal or greater
to 21. That is all cool that we had this little Computer Science
Investigation, but how to fix that - i.e. how to have proper timeouts
for your installations ? Ideally from somewhere you configure and/or
invoke your builds. It turns out that gradle supports invoking just
enough Java for us to use there. In your **gradle.build** as the very
first lines: 

.. code-block:: groovy

	println "setting global timeout for apk installation to 10 minutes"
	com.android.ddmlib.DdmPreferences.setTimeOut(600000)

	android {
		compileSdkVersion compileSdk
		buildToolsVersion buildTools
	[...]

That's it. Invoke your android tests with
**ADB\_INSTALL\_TIMEOUT** env variable set **AND** have the
**DddPreference** set in your gradle.build as in the example above and
you should be golden. Happy droiding !
