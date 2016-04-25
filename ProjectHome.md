This is an Actionscript 3.0 API to access all the available Vkontakte web services. This should hopefully save some people time from doing all the grunt work. It is currently a work in progress so not all the services are currently available.


Usage:
```
import ru.vkontakte.VKApp;
var func:Function = function(res:XML):void { 
    if (res.name() == "response") { ... }
};

var vk:VKApp = new VKApp(__this_Application___.parameters, __app_id__, __app_secret__, __test_mode_on___);

if (!vk.is_valid) {
  Alert.show("This is snatch copy, see original at #api_id");
}

vk.putVariable(566, "some value", null);
vk.getVariable(566, func);

vk.setMaxScores(16, null);
vk.getHighScores(func);
vk.setHighScore(777, null);

....
vk.viewer.putVariable(1300, "some value", null);

vk.user.getVariable(1300, func);
vk.viewer.getVariable(1300, func);
vk.get_user(123456).getVariable(1300, func);

vk.viewer.getUserInfo(func);
vk.get_user(123456).getUserInfo(func);

....
vk.session.putVariable(4000, "some value", null);
vk.get_session(123456).getVariable(4000, func);
vk.session.sendMessage("some message", null);
vk.session.getMessages(func);
vk.get_session(123456).getMessages(func, 10);
```