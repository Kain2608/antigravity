package com.sportpj.sportpj.helpers;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;

public class PermissionUtil {

    public static boolean hasPermission(HttpServletRequest request, String permission) {
        List<String> permissions =
                (List<String>) request.getAttribute("permissions");

        return permissions != null && permissions.contains(permission);
    }
}