<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    // Check if user is logged in
    if (session.getAttribute("studentId") == null) {
        response.sendRedirect("student-login.jsp");
        return;
    }

    String studentName = (String) session.getAttribute("studentName");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard - Online Examination System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background-color: #f9fafb;
            min-height: 100vh;
        }

        header {
            background: white;
            border-bottom: 1px solid #e5e7eb;
            box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
        }

        .header-container {
            max-width: 1280px;
            margin: 0 auto;
            padding: 1rem 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        h1 {
            font-size: 1.5rem;
            color: #1f2937;
        }

        .header-right {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #374151;
        }

        .btn {
            padding: 0.5rem 1rem;
            border-radius: 0.375rem;
            cursor: pointer;
            font-size: 0.875rem;
            font-weight: 500;
            transition: all 0.2s;
        }

        .btn-outline {
            background: white;
            color: #374151;
            border: 1px solid #d1d5db;
        }

        .btn-outline:hover {
            background-color: #f9fafb;
        }

        .btn-primary {
            background-color: #2563eb;
            color: white;
            border: none;
        }

        .btn-primary:hover {
            background-color: #1d4ed8;
        }

        .main-content {
            max-width: 1280px;
            margin: 0 auto;
            padding: 2rem 1.5rem;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            border: 1px solid #e5e7eb;
            border-radius: 0.5rem;
            padding: 1.5rem;
        }

        .stat-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .stat-info h3 {
            font-size: 0.875rem;
            color: #6b7280;
            font-weight: 400;
            margin-bottom: 0.25rem;
        }

        .stat-info p {
            font-size: 1.875rem;
            font-weight: 600;
            color: #1f2937;
        }

        .stat-icon {
            padding: 0.75rem;
            border-radius: 0.5rem;
        }

        .stat-icon svg {
            width: 1.5rem;
            height: 1.5rem;
        }

        .card {
            background: white;
            border: 1px solid #e5e7eb;
            border-radius: 0.5rem;
            margin-bottom: 2rem;
        }

        .card-header {
            padding: 1.5rem;
            border-bottom: 1px solid #e5e7eb;
        }

        .card-title {
            font-size: 1.25rem;
            color: #1f2937;
            font-weight: 600;
        }

        .card-description {
            font-size: 0.875rem;
            color: #6b7280;
            margin-top: 0.25rem;
        }

        .card-content {
            padding: 1.5rem;
        }

        .exam-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem;
            border: 1px solid #e5e7eb;
            border-radius: 0.5rem;
            margin-bottom: 1rem;
            transition: box-shadow 0.2s;
        }

        .exam-item:hover {
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }

        .exam-info h3 {
            font-size: 1.125rem;
            color: #1f2937;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .exam-details {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            font-size: 0.875rem;
            color: #6b7280;
        }

        .status-badge {
            display: inline-block;
            padding: 0.25rem 0.5rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 500;
            margin-left: 0.75rem;
        }

        .status-completed {
            background-color: #d1fae5;
            color: #065f46;
        }

        .status-available {
            background-color: #dbeafe;
            color: #1e40af;
        }

        .status-upcoming {
            background-color: #f3f4f6;
            color: #374151;
        }

        .score-highlight {
            color: #059669;
            font-weight: 500;
        }

        @media (max-width: 768px) {
            .exam-item {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }
        }
    </style>
</head>
<body>