# Truck Routing and Delivery Prototype

## Overview

This project implements a prototype for truck routing and delivery using graph theory and optimization techniques. The goal is to efficiently deliver orders from a central warehouse to various consumers while considering capacity constraints of the truck.

## Features

- **Graph Representation:** Utilizes the NetworkX library to represent the delivery network as a graph.
- **Heuristic Delivery:** Implements a heuristic-based approach to deliver orders without optimization constraints.
- **Constraint Satisfaction Problem (CSP):** Provides a CSP-based solution to optimize the delivery route while considering capacity limitations of the truck.

## Project Structure

- **`truck_delivery.py`:** Python script containing the main logic for creating the graph, delivering orders using heuristics, and solving the CSP.
- **`requirements.txt`:** Specifies the required Python packages.

## Getting Started

1. **Clone the repository:**

    ```bash
    git clone https://github.com/your-username/truck-routing-delivery.git
    ```

2. **Navigate to the project directory:**

    ```bash
    cd truck-routing-delivery
    ```

3. **Install dependencies:**

    ```bash
    pip install -r requirements.txt
    ```

4. **Run the main script:**

    ```bash
    python truck_delivery.py
    ```

## Usage

- Follow the on-screen instructions to input orders, quantities, and observe the delivery process.
- The script demonstrates both heuristic and CSP-based approaches for order delivery.

## Dependencies

- **NetworkX:** A Python library for creating, analyzing, and visualizing complex networks.

## Acknowledgments

- This project is inspired by real-world logistics challenges and aims to showcase the application of graph theory in optimizing delivery routes.

Feel free to explore and contribute to the project by optimizing delivery strategies, adding new features, or incorporating additional optimization algorithms.
