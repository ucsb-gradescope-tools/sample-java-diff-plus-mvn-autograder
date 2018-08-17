import org.junit.Test;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertArrayEquals;

import com.gradescope.jh61b.grader.GradedTest;

public class AssignmentTest 
{  
    @Test
    @GradedTest(name="Test hello()", max_score=10)
    public void testHello()
    {
      Assignment a = new Assignment();
      assertEquals(a.hello(),"Hello, world!"); 
    }

    @Test
    @GradedTest(name="Test default constructor", max_score=10)
    public void testDefaultConstructor()
    {
        Assignment a = new Assignment();
        assertEquals(a.myNumber, 0); 
    }

    @Test
    @GradedTest(name="Test constructor with int argument", max_score=10, visibility="hidden")
    public void testConstructorInt1()
    {
        Assignment a = new Assignment(10);
        assertEquals(a.myNumber, 10); 
    }

    @Test
    @GradedTest(name="Test add()", max_score=10, visibility="hidden")
    public void testConstructorInt2()
    {
        Assignment a = new Assignment();
        assertEquals(a.add(5), 5); 
    }

    @Test
    @GradedTest(name="Test add()", max_score=10, visibility="hidden")
    public void testConstructorInt()
    {
        Assignment a = new Assignment(5);
        assertEquals(a.add(10), 15); 
    }
}