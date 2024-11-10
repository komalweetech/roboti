class VersionService {
  static bool checkVersion(String storeVesrion, String serverVersion) {
    var versions = [];

    if (storeVesrion.length > serverVersion.length) {
      versions = __setServerVesrion(storeVesrion, serverVersion);
    } else {
      versions = __setAppVesrion(storeVesrion, serverVersion);
    }

    if (int.parse(versions.first) >= int.parse(versions.last)) {
      return false;
    }

    return true;
  }

  static List<String> __setServerVesrion(String v1, String v2) {
    List<String> ver1 = v1.split(".");
    List<String> ver2 = v2.split(".");
    for (int i = 0; i < ver2.length; i++) {
      if (ver2[i].length < ver1[i].length) {
        while (ver2[i].length != ver1[i].length) {
          ver2[i] += "0"; // "${ver2[i]}0";
        }
      }
    }

    return [ver1.join(""), ver2.join("")];
  }

  static List<String> __setAppVesrion(String v1, String v2) {
    List<String> ver1 = v2.split(".");
    List<String> ver2 = v1.split(".");
    for (int i = 0; i < ver2.length; i++) {
      if (ver2[i].length < ver1[i].length) {
        while (ver2[i].length != ver1[i].length) {
          ver2[i] += "0"; // "${ver2[i]}0";
        }
      }
    }

    return [ver2.join(""), ver1.join("")];
  }
}
