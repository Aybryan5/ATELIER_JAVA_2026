package fr.bryan.taskmanager.servlet;

import fr.bryan.taskmanager.model.Task;
import fr.bryan.taskmanager.util.TaskSession;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

public class DeleteTaskServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String id = request.getParameter("id");
        ArrayList<Task> tasks = TaskSession.getTasks(request.getSession());
        tasks.removeIf(task -> task.getId().equals(id));

        response.sendRedirect(request.getContextPath() + "/tasks.jsp?deleted=true");
    }
}
