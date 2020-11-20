import com.intuit.karate.KarateOptions;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import java.text.SimpleDateFormat;
import java.util.Date;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import static org.junit.Assert.*;
import org.junit.Test;

@KarateOptions(tags = "~@ignore")
public class TestRunner {

    public static String formatMilliseconds(long myMilliseconds) {
        SimpleDateFormat sdf = new SimpleDateFormat("MMM dd,yyyy HH:mm:ss");
        Date resultDate = new Date(myMilliseconds);
        return sdf.format(resultDate);
    }

    @BeforeClass
    public static void before() {
        String myMilliseconds = formatMilliseconds(System.currentTimeMillis());
        System.out.println("Run Features Start -> " + myMilliseconds);
    }

    @AfterClass
    public static void after() {
        String myMilliseconds = formatMilliseconds(System.currentTimeMillis());
        System.out.println("Run Features End -> " + myMilliseconds);
    }

    @Test
    public void testParallel() {
        Results results = Runner.parallel(getClass(), 5);
        generateReport(results.getReportDir());
        System.out.println("The files to prepare the report are taken from:\n" + results.getReportDir());
       assertEquals(results.getErrorMessages(), 0, results.getFailCount());
    }

    public static void generateReport(String karateOutputPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[]{"json"}, true);
        List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("target"), "swagger-petStore");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }

}