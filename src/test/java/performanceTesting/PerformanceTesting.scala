package performanceTesting

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import io.gatling.core.scenario.Simulation
import scala.concurrent.duration._


class PerformanceTesting extends Simulation {

    val userAuthentication = scenario(scenarioName="Authentication test").exec(karateFeature( name="classpath:feature/userAuth.feature"))

    setUp(
            userAuthentication.inject(rampUsers(users=10).during(10 seconds))
    )

}
