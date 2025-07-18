package com.example.demoforSayan.suduko;

public class SudokuSolver {

    private static final int SIZE = 9;

    public static void main(String[] args) {
        int[][] board = {
            {0, 4, 7, 1, 0, 0, 0, 0, 0},
            {7, 2, 8, 0, 6, 5, 0, 0, 0},
            {0, 0, 0, 0, 5, 0, 0, 0, 7},
            {1, 0, 6, 9, 0, 2, 0, 0, 0},
            {3, 9, 0, 0, 5, 0, 0, 0, 0},
            {0, 0, 0, 0, 0, 0, 8, 5, 0},
            {0, 1, 2, 3, 0, 8, 0, 0, 4},
            {0, 3, 5, 0, 4, 0, 0, 0, 2},
            {2, 4, 0, 9, 0, 0, 0, 0, 0}
        };

        if (solve(board)) {
            System.out.println("Solved Sudoku:");
            printBoard(board);
        } else {
            System.out.println("No solution exists for the given Sudoku puzzle.");
        }
    }

    // Solving function using backtracking
    private static boolean solve(int[][] board) {
        for (int row = 0; row < SIZE; row++) {
            for (int col = 0; col < SIZE; col++) {
                if (board[row][col] == 0) {
                    for (int num = 1; num <= SIZE; num++) {
                        if (isValid(board, row, col, num)) {
                            board[row][col] = num;
                            if (solve(board)) return true;
                            board[row][col] = 0; // backtrack
                        }
                    }
                    return false; // no valid number found
                }
            }
        }
        return true; // puzzle solved
    }

    // Check if placing num at board[row][col] is valid
    private static boolean isValid(int[][] board, int row, int col, int num) {
        for (int i = 0; i < SIZE; i++) {
            if (board[row][i] == num || board[i][col] == num) return false;
        }

        int boxRow = (row / 3) * 3;
        int boxCol = (col / 3) * 3;

        for (int i = boxRow; i < boxRow + 3; i++) {
            for (int j = boxCol; j < boxCol + 3; j++) {
                if (board[i][j] == num) return false;
            }
        }

        return true;
    }

    // Print the Sudoku board
    private static void printBoard(int[][] board) {
        for (int row = 0; row < SIZE; row++) {
            if (row % 3 == 0 && row != 0) {
                System.out.println("------+-------+------");
            }
            for (int col = 0; col < SIZE; col++) {
                if (col % 3 == 0 && col != 0) System.out.print("| ");
                System.out.print(board[row][col] + " ");
            }
            System.out.println();
        }
    }
}
