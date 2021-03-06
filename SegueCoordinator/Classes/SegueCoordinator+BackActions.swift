
import UIKit

// MARK: Back actions

public extension SegueCoordinator {

    /**
     Pops view controller from the stack of the current navigation controller.

     - Warning: If the top view controller doesn't wrapped in navigation controller the pop action will do nothing.

     - Parameter animated: Specify true to animate the transition. Otherwise, specify false.
     */

    func pop(animated: Bool = true) {
        topNavigationController?.popViewController(animated: animated)
    }

    /**
     Dismiss current modal view controller.

     - Warning: If the top view controller doesn't present modally the closeModal action will do nothing.

     - Parameter animated: Specify true to animate the transition. Otherwise, specify false.
     - Parameter completion: The block to execute after the view controller is dismissed.
     */

    func closeModal(animated: Bool = true, completion: (() -> Void)? = nil) {
        guard let presentingController = topController.presentingViewController else {
            completion?()
            return
        }

        presentingController.dismiss(animated: animated, completion: completion)
    }

    /**
     This method will make a transition to the farthest matching controller. It performs searching for the first view controller matching the specified type. Then it closes all modal view controllers above the found view controller's stack and pops navigation stack to make the found view controller the top. In other words, the found view controller becomes the top and visible.

     - Parameter type: Type of required view controller.
     - Parameter animated: specify true if you want to animate the transition. Specify false otherwise.
     - Parameter completion: The block to execute after unwind transitions are finished.
     */
    func unwindToFirst<T: UIViewController>(type: T.Type, animated: Bool = true, completion: (() -> Void)? = nil) {
        unwindToFirst(animated: animated, where: {$0 is T}, completion: completion)
    }

    /**
     This method will make a transition to the closest matching controller. It performs searching for the last view controller matching the specified type. Then it closes all modal view controllers above the found view controller's stack and pops navigation stack to make the found view controller the top. In other words, the found view controller becomes the top and visible.

     - Parameter type: Type of required view controller.
     - Parameter animated: specify true if you want to animate the transition. Specify false otherwise.
     - Parameter completion: The block to execute after unwind transitions are finished.
     */
    func unwindToLast<T: UIViewController>(type: T.Type, animated: Bool = true, completion: (() -> Void)? = nil) {
        unwindToLast(animated: animated, where: {$0 is T}, completion: completion)
    }

    /**
     This method will make a transition to the farthest matching controller. It performs searching for the first view controller matching the specified predicate. Then it closes all modal view controllers above the found view controller's stack and pops navigation stack to make the found view controller the top. In other words, the found view controller becomes the top and visible.

     - Parameter animated: specify true if you want to animate the transition. Specify false otherwise.
     - Parameter predicate: Searching conditions. Returns true if the view controller passed in its argument fulfills conditions of the search. Returns false otherwise.
     - Parameter controller: Controller to check for the searching conditions.
     - Parameter completion: The block to execute after unwind transitions are finished.
     */
    func unwindToFirst(animated: Bool = true, where predicate: (UIViewController) -> Bool, completion: (() -> Void)? = nil) {
        guard let controller = findFirst(where: predicate) else {
            print("Unable to find view controller")
            completion?()
            return
        }

        unwindToController(controller, animated: animated, completion: completion)
    }

    /**
     This method will make a transition to the closest matching controller. It performs searching for the last view controller matching the specified predicate. Then it closes all modal view controllers above the found view controller's stack and pops navigation stack to make the found view controller the top. In other words, the found view controller becomes the top and visible.

     - Parameter animated: specify true if you want to animate the transition. Specify false otherwise.
     - Parameter predicate: Searching conditions. Returns true if the view controller passed in its argument fulfills conditions of the search. Returns false otherwise.
     - Parameter controller: Controller to check for the searching conditions.
     - Parameter completion: The block to execute after unwind transitions are finished.
     */
    func unwindToLast(animated: Bool = true, where predicate: (_ controller: UIViewController) -> Bool, completion: (() -> Void)? = nil) {
        guard let controller = findLast(where: predicate) else {
            print("Unable to find view controller")
            completion?()
            return
        }

        unwindToController(controller, animated: animated, completion: completion)
    }

    /**
     Closes all modal view controllers above the specified view controller's stack and pops navigation stack to make it the top. In other words, the specified view controller becomes the top and visible.

     - Parameter controller: controller to navigate to
     - Parameter animated: specify true if you want to animate the transition. Specify false otherwise.
     - Parameter completion: The block to execute after unwind transitions are finished.
     */
    func unwindToController(_ controller: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        func popStack() {
            if controller is UINavigationController {
                completion?()
                return
            }

            if let navigationController = controller.navigationController {
                if navigationController.viewControllers.contains(controller) {
                    navigationController.popToViewController(controller, animated: animated)
                }
            }
            completion?()
        }

        if controller.presentedViewController != nil {
            controller.dismiss(animated: animated, completion: popStack)
        } else {
            popStack()
        }
    }
}
