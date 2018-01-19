package com.yhyt.health;

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

/**
 * Unit test for simple App.
 */
public class AppTest 
    extends TestCase
{

    /**
     * Create the test case
     *
     * @param testName name of the test case
     */
    public AppTest( String testName )
    {
        super( testName );
    }

    /**
     * @return the suite of tests being tested
     */
    public static Test suite()
    {
        return new TestSuite( AppTest.class );
    }

    /**
     * Rigourous Test :-)
     */
    public void testApp()
    {
        assertTrue( true );
    }

    @org.junit.Test
    public void testReg(){
        String s="<p>11ddfsdsfsfsf</p><p>2&nbsp;</p><p>2f</p><p><br></p><p>fdsf</p><p><br></p><p><br></p><p>3 &nbsp;ffsdfsdfsdfsdfsfsdfsfs</p>";
        System.out.println(s.replaceAll("\\<p>","").replaceAll("\\</p>","\n")
        .replaceAll("\\<br>","\n").replaceAll("&nbsp;"," "));
    }
}
