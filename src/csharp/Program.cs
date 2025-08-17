using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace TestApp;

// Test class for LSP features
public class Calculator
{
    public int Add(int a, int b) => a + b;
    public int Subtract(int a, int b) => a - b;
    public double Divide(int a, int b) => b != 0 ? (double)a / b : throw new DivideByZeroException();
}

// Test record for modern C# features
public record Person(string Name, int Age, string Email);

// Test interface for go-to-definition
public interface IDataService
{
    Task<List<Person>> GetPeopleAsync();
    Task<Person?> GetPersonByIdAsync(int id);
}

// Implementation to test navigation
public class DataService : IDataService
{
    private readonly List<Person> _people = new()
    {
        new("Alice Johnson", 30, "alice@example.com"),
        new("Bob Smith", 25, "bob@test.org"),
        new("Carol Davis", 35, "carol@company.com")
    };

    public Task<List<Person>> GetPeopleAsync()
    {
        return Task.FromResult(_people);
    }

    public Task<Person?> GetPersonByIdAsync(int id)
    {
        var person = id >= 0 && id < _people.Count ? _people[id] : null;
        return Task.FromResult(person);
    }
}

// Main program to test debugging
class Program
{
    static async Task Main(string[] args)
    {
        Console.WriteLine("C# Neovim Test Application");
        
        // Test calculator functionality
        var calc = new Calculator();
        Console.WriteLine($"5 + 3 = {calc.Add(5, 3)}");
        Console.WriteLine($"10 - 4 = {calc.Subtract(10, 4)}");
        Console.WriteLine($"15 / 3 = {calc.Divide(15, 3)}");
        
        // Test data service
        var dataService = new DataService();
        var people = await dataService.GetPeopleAsync();
        
        Console.WriteLine("\nPeople in database:");
        for (int i = 0; i < people.Count; i++)
        {
            var person = people[i];
            Console.WriteLine($"{i}: {person.Name} ({person.Age}) - {person.Email}");
        }
        
        // Test error handling for debugging
        try
        {
            var invalidPerson = await dataService.GetPersonByIdAsync(999);
            Console.WriteLine($"Found: {invalidPerson?.Name ?? "No person found"}");
            
            // This will throw an exception for debugging test
            var result = calc.Divide(10, 0);
            Console.WriteLine($"Division result: {result}");
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error: {ex.Message}");
        }
        
        Console.WriteLine("Test completed successfully!");
    }
}