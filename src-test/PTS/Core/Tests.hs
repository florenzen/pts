module PTS.Core.Tests where

import Test.Framework (testGroup)
import Test.Framework.Providers.QuickCheck2 (testProperty)
import Test.Framework.Providers.HUnit
import Test.HUnit (assertBool)

import PTS.AST
import PTS.Instances
import qualified PTS.Core.Properties as Prop

import Test.Property (test)

x :: Name
x = read "x"

y :: Name
y = read "y"

z :: Name
z = read "z"

alphaEquivalenceReflexive
  =  testProperty "alpha equivalence is reflexive"
       Prop.alphaEquivalenceReflexive

alphaEquivalenceSymmetric
  =  testProperty "symmetry"
       Prop.alphaEquivalenceSymmetric

alphaEquivalenceTransitive
  =  testProperty "transitivity"
       Prop.alphaEquivalenceTransitive

alphaEquivalenceShareFreevars
  =  testProperty "same free variables" $
       Prop.alphaEquivalenceShareFreevars

ndotsLength
  =  testProperty "n characters long" $
       Prop.ndotsLength

ndotsContainsDots
  =  testProperty "consists only of dots" $
       Prop.ndotsContainsDots

alphaEquivalent t1 t2
  =  testCase (show t1 ++ " alpha-equiv. to " ++ show t2) $
       assertBool "False negative: terms should be considered alpha-equiv." $
       t1 == t2

alphaInequivalent t1 t2
  =  testCase (show t1 ++ " not alpha-equiv. to " ++ show t2) $
       assertBool "False positive: terms should not be considered alpha-equiv." $
       t1 /= t2

tests
  =  testGroup "PTS.Core"
     [  testGroup "alpha equivalence"
        [  alphaEquivalenceReflexive
        ,  alphaEquivalenceSymmetric
        ,  alphaEquivalenceTransitive
        ,  alphaEquivalenceShareFreevars
        ,  alphaEquivalent x x
        ,  alphaEquivalent (mkLam x (mkVar x) (mkVar x)) (mkLam y (mkVar x) (mkVar y))
        ,  alphaEquivalent (mkLam y (mkVar x) (mkVar y)) (mkLam x (mkVar x) (mkVar x))
        ,  alphaEquivalent (mkPi y (mkVar x) (mkVar y)) (mkPi x (mkVar x) (mkVar x))
        ,  alphaEquivalent (mkPi x (mkVar x) (mkVar x)) (mkPi y (mkVar x) (mkVar y))
        ,  alphaInequivalent (mkPi x (mkVar x) (mkVar x)) (mkPi y (mkVar y) (mkVar y))
        ,  alphaInequivalent (mkLam x (mkVar x) (mkVar x)) (mkLam y (mkVar y) (mkVar y))
        ,  alphaInequivalent (mkLam x (mkVar x) (mkVar x)) (mkPi x (mkVar x) (mkVar x))
        ]
     ,  testGroup "n dots"
        [  ndotsLength
        ,  ndotsContainsDots
        ]
     ]
