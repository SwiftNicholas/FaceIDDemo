# FaceIDDemo
A very simple implementation of BiometricID using built in iOS security.
This works with both faceID and touchID.

In order to preview, either a physical device will be needed or the following steps need to be taken:

1. Run in simulator
2. Go to the Features Menu
3. Features -> Enroll
*** If already enrolled must close app in simulator and click Enroll again then click Enroll to re-setup the simulator.
5. Features -> Matching or non-matching touch

There are 2 types of enrollment:
- The application must be allowed to use biometrics, this is found in settings of the device if it is disabled or if the user declines to give the app permission when asked then the app is no longer enrolled
- The user's enrollment in biometric data on the device, typically the adoption of biometric data is very high because the experience is seamless it is not mandatory however and can't be assumed to be available.

Application enrollment/permissions are persistent unless the app is uninstalled, so after first launch it will not ask to use biometrics again if it is declined.
