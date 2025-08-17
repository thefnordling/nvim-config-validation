"""
Python test module for Neovim configuration validation.
Tests LSP features, debugging, formatting, and linting.
"""

import asyncio
import json
import logging
from dataclasses import dataclass
from pathlib import Path
from typing import Dict, List, Optional, Union, Sequence
from datetime import datetime


# Configure logging for testing
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


@dataclass
class Person:
    """Test dataclass for LSP features."""
    name: str
    age: int
    email: str
    created_at: Optional[datetime] = None

    def __post_init__(self):
        if self.created_at is None:
            self.created_at = datetime.now()

    def is_adult(self) -> bool:
        """Test method for go-to-definition."""
        return self.age >= 18


class DataService:
    """Test service class for navigation and debugging."""
    
    def __init__(self):
        self._people: List[Person] = [
            Person("Alice Johnson", 30, "alice@example.com"),
            Person("Bob Smith", 25, "bob@test.org"), 
            Person("Carol Davis", 35, "carol@company.com"),
        ]
    
    async def get_people(self) -> List[Person]:
        """Get all people - test async functionality."""
        await asyncio.sleep(0.1)  # Simulate async operation
        return self._people
    
    def find_person_by_email(self, email: str) -> Optional[Person]:
        """Find person by email - test for debugging."""
        for person in self._people:
            if person.email == email:
                return person
        return None
    
    def add_person(self, person: Person) -> bool:
        """Add new person - test for refactoring."""
        if self.find_person_by_email(person.email):
            logger.warning(f"Person with email {person.email} already exists")
            return False
        
        self._people.append(person)
        logger.info(f"Added person: {person.name}")
        return True


class Calculator:
    """Calculator class for testing math operations."""
    
    @staticmethod
    def add(a: Union[int, float], b: Union[int, float]) -> Union[int, float]:
        """Add two numbers."""
        return a + b
    
    @staticmethod  
    def divide(a: Union[int, float], b: Union[int, float]) -> float:
        """Divide two numbers - will raise exception for testing."""
        if b == 0:
            raise ValueError("Cannot divide by zero")
        return a / b
    
    def calculate_average(self, numbers: Sequence[Union[int, float]]) -> float:
        """Calculate average - test for debugging with lists."""
        if not numbers:
            raise ValueError("Cannot calculate average of empty list")
        
        total = sum(numbers)
        count = len(numbers)
        return total / count


def save_people_to_file(people: List[Person], filename: str) -> None:
    """Save people to JSON file - test file operations."""
    data = []
    for person in people:
        data.append({
            "name": person.name,
            "age": person.age,
            "email": person.email,
            "created_at": person.created_at.isoformat() if person.created_at else None,
            "is_adult": person.is_adult()
        })
    
    file_path = Path(filename)
    with file_path.open('w') as f:
        json.dump(data, f, indent=2)
    
    logger.info(f"Saved {len(people)} people to {filename}")


async def main():
    """Main function to test all features."""
    print("Python Neovim Test Application")
    print("=" * 40)
    
    # Test calculator
    calc = Calculator()
    print(f"5 + 3 = {calc.add(5, 3)}")
    print(f"10 / 2 = {calc.divide(10, 2)}")
    
    numbers = [1, 2, 3, 4, 5]
    avg = calc.calculate_average(numbers)
    print(f"Average of {numbers} = {avg}")
    
    # Test data service
    service = DataService()
    people = await service.get_people()
    
    print(f"\nFound {len(people)} people:")
    for person in people:
        status = "adult" if person.is_adult() else "minor"
        print(f"- {person.name} ({person.age}) - {status}")
    
    # Test adding new person
    new_person = Person("David Wilson", 28, "david@newdomain.com")
    if service.add_person(new_person):
        print(f"Successfully added: {new_person.name}")
    
    # Test file operations
    save_people_to_file(people, "people.json")
    
    # Test error handling for debugging
    try:
        result = calc.divide(10, 0)
        print(f"Division result: {result}")
    except ValueError as e:
        print(f"Caught error: {e}")
    
    try:
        empty_avg = calc.calculate_average([])
        print(f"Empty average: {empty_avg}")
    except ValueError as e:
        print(f"Caught error: {e}")
    
    print("\nTest completed successfully!")


if __name__ == "__main__":
    # Run the async main function
    asyncio.run(main())