// Package main provides test code for validating Neovim Go configuration
package main

import (
	"encoding/json"
	"fmt"
	"log"
	"os"
	"time"

	"github.com/sirupsen/logrus"
)

// Person represents a person entity for testing structs and methods
type Person struct {
	ID        int       `json:"id"`
	Name      string    `json:"name"`
	Age       int       `json:"age"`
	Email     string    `json:"email"`
	CreatedAt time.Time `json:"created_at"`
}

// NewPerson creates a new person - test constructor pattern
func NewPerson(id int, name string, age int, email string) *Person {
	return &Person{
		ID:        id,
		Name:      name,
		Age:       age,
		Email:     email,
		CreatedAt: time.Now(),
	}
}

// IsAdult checks if person is adult - test method for go-to-definition
func (p *Person) IsAdult() bool {
	return p.Age >= 18
}

// String implements Stringer interface
func (p *Person) String() string {
	status := "minor"
	if p.IsAdult() {
		status = "adult"
	}
	return fmt.Sprintf("%s (%d) - %s [%s]", p.Name, p.Age, p.Email, status)
}

// DataService manages person data - test service pattern
type DataService struct {
	people []*Person
	logger *logrus.Logger
}

// NewDataService creates a new data service
func NewDataService() *DataService {
	logger := logrus.New()
	logger.SetLevel(logrus.InfoLevel)

	return &DataService{
		people: []*Person{
			NewPerson(1, "Alice Johnson", 30, "alice@example.com"),
			NewPerson(2, "Bob Smith", 25, "bob@test.org"),
			NewPerson(3, "Carol Davis", 35, "carol@company.com"),
		},
		logger: logger,
	}
}

// GetAllPeople returns all people
func (ds *DataService) GetAllPeople() []*Person {
	ds.logger.Info("Fetching all people")
	return ds.people
}

// FindPersonByEmail finds person by email - test for debugging
func (ds *DataService) FindPersonByEmail(email string) *Person {
	ds.logger.WithField("email", email).Info("Searching for person")

	for _, person := range ds.people {
		if person.Email == email {
			ds.logger.WithField("person", person.Name).Info("Person found")
			return person
		}
	}

	ds.logger.Warn("Person not found")
	return nil
}

// AddPerson adds a new person - test slice operations
func (ds *DataService) AddPerson(person *Person) error {
	if person == nil {
		return fmt.Errorf("person cannot be nil")
	}

	// Check for duplicate email
	if existing := ds.FindPersonByEmail(person.Email); existing != nil {
		return fmt.Errorf("person with email %s already exists", person.Email)
	}

	person.ID = len(ds.people) + 1
	ds.people = append(ds.people, person)
	ds.logger.WithField("person", person.Name).Info("Person added successfully")

	return nil
}

// Calculator provides math operations for testing
type Calculator struct{}

// Add adds two numbers
func (c *Calculator) Add(a, b int) int {
	return a + b
}

// Divide divides two numbers - will panic for testing debugging
func (c *Calculator) Divide(a, b int) float64 {
	if b == 0 {
		panic("division by zero")
	}
	return float64(a) / float64(b)
}

// CalculateAverage calculates average of slice - test slice operations
func (c *Calculator) CalculateAverage(numbers []int) float64 {
	if len(numbers) == 0 {
		panic("cannot calculate average of empty slice")
	}

	sum := 0
	for _, num := range numbers {
		sum += num
	}

	return float64(sum) / float64(len(numbers))
}

// savePeopleToFile saves people to JSON file - test file operations
func savePeopleToFile(people []*Person, filename string) error {
	file, err := os.Create(filename)
	if err != nil {
		return fmt.Errorf("failed to create file: %w", err)
	}
	defer file.Close()

	encoder := json.NewEncoder(file)
	encoder.SetIndent("", "  ")

	if err := encoder.Encode(people); err != nil {
		return fmt.Errorf("failed to encode JSON: %w", err)
	}

	log.Printf("Saved %d people to %s", len(people), filename)
	return nil
}

// demonstrateErrorHandling shows Go error handling patterns
func demonstrateErrorHandling(calc *Calculator, ds *DataService) {
	fmt.Println("\n--- Testing Error Handling ---")

	// Test division by zero (will panic)
	defer func() {
		if r := recover(); r != nil {
			fmt.Printf("Recovered from panic: %v\n", r)
		}
	}()

	// Test normal division
	result := calc.Divide(10, 2)
	fmt.Printf("10 / 2 = %.2f\n", result)

	// Test adding nil person
	if err := ds.AddPerson(nil); err != nil {
		fmt.Printf("Error adding nil person: %v\n", err)
	}

	// This will panic and be recovered
	result = calc.Divide(10, 0)
	fmt.Printf("10 / 0 = %.2f\n", result) // Won't reach this line
}

func main() {
	fmt.Println("Go Neovim Test Application")
	fmt.Println("=" + fmt.Sprintf("%*s", 39, "="))

	// Test calculator
	calc := &Calculator{}
	fmt.Printf("5 + 3 = %d\n", calc.Add(5, 3))
	fmt.Printf("15 / 3 = %.2f\n", calc.Divide(15, 3))

	numbers := []int{1, 2, 3, 4, 5}
	avg := calc.CalculateAverage(numbers)
	fmt.Printf("Average of %v = %.2f\n", numbers, avg)

	// Test data service
	service := NewDataService()
	people := service.GetAllPeople()

	fmt.Printf("\nFound %d people:\n", len(people))
	for i, person := range people {
		fmt.Printf("%d: %s\n", i+1, person.String())
	}

	// Test adding new person
	newPerson := NewPerson(0, "David Wilson", 28, "david@newdomain.com")
	if err := service.AddPerson(newPerson); err != nil {
		fmt.Printf("Error adding person: %v\n", err)
	} else {
		fmt.Printf("Successfully added: %s\n", newPerson.Name)
	}

	// Test file operations
	if err := savePeopleToFile(people, "people.json"); err != nil {
		fmt.Printf("Error saving to file: %v\n", err)
	}

	// Test error handling and panics
	demonstrateErrorHandling(calc, service)

	fmt.Println("\nTest completed successfully!")
}
